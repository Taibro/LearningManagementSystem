import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.util.Map;

public class TestCloudinary {
    public static void main(String[] args) throws Exception {
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dsj54uz5e",
            "api_key", "998875625551323",
            "api_secret", "qFhce3p931v1AAfZ87JyVn9ERkU"
        ));
        Map result = cloudinary.api().usage(ObjectUtils.emptyMap());
        System.out.println(result);
    }
}
