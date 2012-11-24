//
// aspire

package aspire.util {

public interface XmlClassMap
{
    function getConstructorParamTypes () :Array;
    function getConstructor (xmlElement :XML) :Function;
}

}
