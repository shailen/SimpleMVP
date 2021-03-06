part of vint;

/**
* The base class for evented models.
*/
abstract class Model {
  ModelAttributes attributes;

  final ModelEvents events = new ModelEvents();

  Model(Map attributes){
    this.attributes = new ModelAttributes(this, attributes);
  }

  get id => attributes["id"];

  bool get saved => attributes.hasId();

  operator [] (String name) => attributes[name];

  operator []= (String name, value) => attributes[name] = value;

  noSuchMethod(InvocationMirror invocation){
    if(invocation.isGetter){
      return this[invocation.memberName];
    } else if (invocation.isSetter){
      var propertyName = _removeEqualsSign(invocation.memberName);
      return this[propertyName] = invocation.positionalArguments[0];
    }

    throw new NoSuchMethodError(this, invocation.memberName, invocation.positionalArguments, invocation.namedArguments);
  }

  _removeEqualsSign(String setter)
    => setter.substring(0, setter.length - 1);
}