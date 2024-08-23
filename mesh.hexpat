#pragma author Tyloth (Cyno Studios)
#pragma description Mesh files for Sins of A Solar Empire 2
#pragma endian little
#pragma array_limit 9999999
#pragma pattern_limit 9999999

import std.core;
import std.string;

struct Header {
    char header[4];
};

struct Vector3f {
    float x, y, z;
} [[static, format("format_vector3f")]];

struct Vector2f {
    float x, y;
} [[static, format("format_vector2f")]];

struct Vector4f {
    float x, y, z, w;
};

struct Rotation {
    Vector3f x, y ,z;
};

struct BoundingBox {
    Vector3f center, extents;
};

struct BoundingSphere {
    Vector3f center;
    float radius;
};

struct VertexData {
    Vector3f position;
    Vector3f normals;
    Vector4f tangents;
    Vector2f uv0;
    u8 has_uv1;
    if (has_uv1 == 0x01) {
        Vector2f uv1;
    }
};

struct SkinnedVertices {
    u32 len [[hidden]];
    u32 key [[hidden]];
    if (len == 0) {
        std::print("Skinned vertices not found.\n");
    }
};

struct Vertices {
    u32 len [[hidden]];
    u32 key [[hidden]];
    VertexData vertex[len];
};

struct VertexIndices {
    u32 len [[hidden]];
    u32 array_begin [[hidden]];
    u32 index[len];
};

struct Primitive {
    u16 material_index;
    u32 vertex_index_start;
    u32 vertex_index_count;
};

struct Primitives {
    u32 len [[hidden]];
    u32 skip [[hidden]];
    Primitive primitive[len];
};

struct Meshpoint {
    u32 len [[hidden]];
    char name[len];
    Vector3f position;
    Rotation rotation;
    u16 bone_index;
};

struct Meshpoints {
    u32 len [[hidden]];
    u32 skip [[hidden]];
    Meshpoint mesh_point[len];
};

struct Bone {
    u8 len [[hidden]];
    char name[len];
    u16 base_pose[16];
};

struct Bones {
    u32 len [[hidden]];
    u32 skip [[hidden]];
    Bone bone[len];
};

struct Material {
    u32 len [[hidden]];
    char name[len];
};

struct Materials {
    u32 len [[hidden]];
    u32 skip [[hidden]];
    Material material[len];
    u8 skip2 [[hidden]];
};

struct MeshData {
    Header header;
    u8 is_skinned;
    BoundingBox bounding_box  [[color("FF0000")]];
    BoundingSphere bounding_sphere [[color("FFFF00")]];
    SkinnedVertices skinned_vertices;
    Vertices vertices [[color("00FF00")]];
    VertexIndices vertex_indices [[color("00FFFF")]];
    Primitives primitives [[color("F72282")]];
    Meshpoints mesh_points [[color("330099")]];
    Bones bones;
    Materials materials [[color("7F82D3")]];
};

fn format_vector3f(Vector3f vec) {
    return std::format("[ {}, {}, {} ]", vec.x, vec.y, vec.z);
};

fn format_vector2f(Vector2f vec) {
    return std::format("[ {}, {} ]", vec.x, vec.y);
};

MeshData mesh @ 0x00;