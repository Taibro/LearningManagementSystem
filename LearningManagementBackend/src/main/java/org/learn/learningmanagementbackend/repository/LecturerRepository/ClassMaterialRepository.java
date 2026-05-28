package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.ClassMaterial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClassMaterialRepository extends JpaRepository<ClassMaterial, Integer> {

    List<ClassMaterial> findByClassObjId(Integer classId);

    @Query("SELECT m FROM ClassMaterial m " +
            "WHERE m.uploadedBy.id = :teacherId " +
            "AND (:classId IS NULL OR m.classObj.id = :classId) " +
            "AND (:docType IS NULL OR m.docType = :docType) " +
            "ORDER BY m.createdAt DESC")
    List<ClassMaterial> searchMaterials(
            @Param("teacherId") Integer teacherId,
            @Param("classId") Integer classId,
            @Param("docType") String docType);
}