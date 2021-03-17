- MVVM (Model View ViewModel) architecture
    - Model (notices changes)
        - UI Independent
        - Data + Logic
        - "The Truth"
    - View (View to View Model : calls Intent function)
        - Reflects the Model
        - Stateless
        - Declared
        - Recycle
        - automatically observes, publications, pulls data and rebuilds
    - View Model (modifies the Model and publishes "somethings changed")
        - Binds View to Models
        - Interpreter
        - Processes Intent
- Types
    - Structure : value type
        - Copied when passed or assigned
        - Copy on write
        - Functional Programming
        - No inheritance
        - "Free" init initialize All vars
        - mutability must be explicitly stated
        - "go to" data structure
        - Everything you've seen so far is a structure (except View which is a protocol)
    - Class  : reference type
        - Passed around via pointers
        - Automatically reference counted
        - Object-oriented programming
        - Inheritance (single)
        - "Free" init initialize NO vars
        - Always mutable
        - Used in specified circumstances
        - The ViewModel in MVVM is always a class (also, UIKit (old-style iOS) is class-based)
- Generics
    - don't care type
- Closure

- Protocol
    - A Protocol is sort of a "stripped-down" struct /  class
    - It has functions and vars, but no implementation (or storage)
    - Declaring a protocol looks very similar to struct or class (just without implementation)
    - protocol inheritance
    - protocol is a type
- extension
    - can add implementations to a protocol using an extension to the protocol
    - Adding code to a structure or class via an extension
- Layout
    - stacks (HStack, VStack), ForEach, .padding
        - alignment: .leading (left to right)
        - HStack(alignment: .firstTextBaseline) {})
    - Spacer(minLength: CGFloat) (draws nothing)
    - Divider()
    - Modifiers (.font or .foregroundColor)
        - .padding(10) points on each side
        - .aspectRatio (.fit / .fill )
    - GeometryReader
        - GeometryProxy
    - Safe Area
        - ZStack { ... }.edgesIgnoringSafeArea([.top])
    - Container (modifier : .frame), .position(CGPoint), .offset(CGSize)
    - @ViewBuilder
        - @ViewBuilder to mark a parameter that returns a View
        - struct GeometryReader<Content> where Content:View {
         init(@ViewBuilder content: @escaping (GeometryProxy) → Content) {...}
        }
    - Shape
        - Shape is a protocol that inherits from View
        - Examples of Shapes : RoundedRectangle, Circle, Capsule, etc.
        - .fill(), .stroke()
        - func fill<S>(_ whatToFillWith: S) → View where S: ShapeStyle
        - S is don't care type
        - S can be anything that implements the ShapeStyle protocol
        - Color, ImagePaint, AngularGradient, LinearGradient
    - Animation
        - ViewModifier : modify views (like aspectRatio and padding)
        - protocol ViewModifier {
              associatedtype Content
              func body (content: Content) → some View {
                       return some View that represents a modification of content }
        }
- Grid
- emun
    - Another variety of data structure in addition to struct and class
    - An enum is a value type(like structure), so it is copied as it is passed around
    - An enum can have methods (and computed properties) but no stored properties...
    - An enum's state is entirely which case it is in and that case's associated data, nothing more
- Optionals
    - An Optional is just an enum. Period, nothing more.
    - can access the associated value either by force(with !)...
    - Or "safely" using if let and then using the safely-gotten associated value in { } (else allowed too)
    - ?? which does "Optional defaulting". It's called the "nil-coalescing operator"
