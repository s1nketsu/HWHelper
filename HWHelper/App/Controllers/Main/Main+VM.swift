extension MainController {
    
    final class ViewModel {
        
        var reloadData: () -> Void = { }
        
        var pinnedRows: [Row] = [
            .item(.init(title: "Закрепленная Злата Заебаннава")),
            .item(.init(title: "Закрепленная Злата Хуева")),
        ]
        
        var groupRows: [Row] = [
            .item(.init(title: "AS1")),
            .item(.init(title: "AS2")),
            .item(.init(title: "AS3")),
            .item(.init(title: "AS4")),
            .item(.init(title: "AS5")),
        ]
        
        var individualRows: [Row] = [
            .item(.init(title: "Злата Саранова")),
            .item(.init(title: "Злата Хуева")),
            .item(.init(title: "Злата Заебаннава")),
            .item(.init(title: "Злата?")),
            .item(.init(title: "Злата!")),
        ]
    }
}
