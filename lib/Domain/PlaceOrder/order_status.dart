abstract class OrderStatus{}

class OrderLoading extends OrderStatus{}
class OrderPacedSuccess extends OrderStatus{}
class OrderPacedFailed extends OrderStatus{}