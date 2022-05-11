import SwiftUI

struct TaskRow: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        // MARK: Cell of tasks
            HStack {
                CheckBox(isComplete: task.isComplete)
                    .onTapGesture {
                        task.isComplete = true
                        try? moc.save()
                        MusicPlayer.shared.playSoundEffect(soundEffect: "CompleteSound")
                    }
                    .padding(.trailing)

                VStack(alignment: .leading, spacing: 0) {
                    Text(task.wrappedName)
                        .font(.title2)
                        .padding(.top)

                    TomatoProgressBar(completePomidoro: Int(task.completeNumberOfPomidoro), countOfPomidoro: Int(task.numberOfPomidoro))
                        .padding(.bottom)
                }

                Spacer()

                NavigationLink {
                    TaskView(task: task)
                } label: {
                    EmptyView()
                }
                .disabled(task.isComplete)
            }
            .roundedRectangleBorder(style: .tomato, cornerRadius: GeometryValue.cornerRadius, lineWidth: GeometryValue.lineWidth)
        }

    struct GeometryValue {
        static var cornerRadius = 15.0
        static var lineWidth = 2.0
    }
}
