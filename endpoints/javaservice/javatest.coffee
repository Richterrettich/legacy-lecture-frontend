java = require("java");
java.classpath.push("/Users/renerichter/NetBeansProjects/Java-Runtime-Compiler/JavaExecutionService/target/JavaExecutionService-1.0-SNAPSHOT-jar-with-dependencies.jar");

AppFacade = java.import "com.lecture.app.AppFacade"

facade = new AppFacade("mock")

console.log(AppFacade.Scope.EXERCISE.toStringSync())
facade.compileSourceSync('import com.lecture.testframework.AbstractTest;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 *
 * @author rene
 */
public class Hugo extends AbstractTest
{

    @Test
    public void getInt()
    {
        Object o = super.createObject("Hugo");
        Integer i = (Integer)super.executeMethod(o,"getInt");
        assertEquals("es sollte 25 sein",25,i.intValue());
    }


    @Override
    public String getExcerciseName()
    {
        return "mock";
    }
}', AppFacade.Scope.TEST)

facade.compileSourceSync('public class Hugo{public int getInt(){return 25;}}',AppFacade.Scope.EXERCISE)


#result = facade.compileTestSourceForErrorJsonSync()
#console.log(result?)
result = facade.executeTestsForFailureJsonSync()
console.log(result)
#console.log(AppFacade.Scope.TEST)