import UIKit

class ViewController: UIViewController {
    
    //MARK: - Model
    
    enum Product: Int {
        case cola = 1000
        case cider = 1100
        case fanta = 1200
        func name() -> String {
            switch self {
            case .cola: return "콜라"
            case .cider: return "사이다"
            case .fanta: return "판다"
            }
        }
    }
    
    enum Input {
        case moneyInput(Int)
        case productSelect(Product)
        case reset
        case none
    }
    
    enum Output {
        case displayMoney(Int)
        case productOut(Product)
        case shortMoneyError
        case change(Int)
    }
    
    struct State {
        let money: Int
        static func initial() -> State {
            return State(money: 0)
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var displayMoney: UILabel!
    
    @IBOutlet weak var productOut: UIImageView!
    
    @IBOutlet weak var textInfo: UILabel!
    
    @IBAction func money100(_ sender: Any) {
        handleProcess("100")
    }
    
    @IBAction func money500(_ sender: Any) {
        handleProcess("500")
    }
    
    @IBAction func money1000(_ sender: Any) {
        handleProcess("1000")
    }
    
    @IBAction func selectCola(_ sender: Any) {
        handleProcess("cola")
    }
    
    @IBAction func selectCider(_ sender: Any) {
        handleProcess("cider")
    }
    
    @IBAction func selectFanta(_ sender: Any) {
        handleProcess("fanta")
    }
    
    @IBAction func reset(_ sender: Any) {
        handleProcess("reset")
    }
    
    //MARK: - Logic
    
    lazy var handleProcess = processHandler(State.initial())
    
    func processHandler(_ initState: State) -> (String) -> Void {
        var state = initState   // memoiozation(힘수 안에 변수를 가둬서 사이드 이펙트 없앰, 함수형 프로그램 활용)
        return { command in
            state = self.operation(self.uiInput(command), self.uiOutput)(state)
        }
    }
    
    func uiInput(_ command: String) -> () -> Input {
        return {
            switch command {
            case "100": return .moneyInput(100)
            case "500": return .moneyInput(500)
            case "1000": return .moneyInput(1000)
            case "cola": return .productSelect(.cola)
            case "cider": return .productSelect(.cider)
            case "fanta": return .productSelect(.fanta)
            case "reset": return .reset
            default: return .none
            }
        }
    }
    
    func uiOutput(_ output: Output) {
        switch output {
        case .displayMoney(let m):
            displayMoney.text = "\(m)"
            
        case .productOut(let p):
            switch p {
            case .cola:
                productOut.image = #imageLiteral(resourceName: "cola_l")
            case .cider:
                productOut.image = #imageLiteral(resourceName: "cider_l")
            case .fanta:
                productOut.image = #imageLiteral(resourceName: "fanta_l")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.productOut.image = nil
            }
            
        case .shortMoneyError:
            textInfo.text = "잔액이 부족합니다."
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.textInfo.text = ""
            }
            
        case .change(let c):
            textInfo.text = "\(c)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.textInfo.text = ""
            }
        }
    }
    
    func operation(_ input: @escaping () -> Input, _ output: @escaping (Output) -> ()) -> (State) -> State {
        return { state in
            let input = input()
            switch input {
            case .moneyInput(let m):
                let money = state.money + m
                output(.displayMoney(money))
                return State(money: money)
                
            case .productSelect(let p):
                if state.money < p.rawValue {
                    output(.shortMoneyError)
                    return state
                }
                output(.productOut(p))
                let money = state.money - p.rawValue
                output(.displayMoney(money))
                return State(money: money)
                
            case .reset:
                output(.change(state.money))
                output(.displayMoney(0))
                return State(money: 0)
                
            case .none:
                return State(money: state.money)
            }
        }
    }
}

