import * as THREE from 'three'
import React, { useRef, useMemo } from "react";
import { Box, Plane, useAspect } from "drei";
import { createPortal, useFrame } from "react-three-fiber";

import "./materials/deformMaterial";
import "./materials/bufferMaterial"

function swap(a,b) {

  let t = a
  a = b
  b = t

}

function Scene() {
  
  const bufferMaterial = useRef()
  
  const textureA = useRef( new THREE.WebGLMultisampleRenderTarget(window.innerWidth, window.innerHeight))
  const textureB = useRef( new THREE.WebGLMultisampleRenderTarget(window.innerWidth, window.innerHeight))

  const bufferScene = useMemo(() => new THREE.Scene(), [])

  const finalQuad = useRef()

  useFrame(({ gl, scene, camera }) => {

    gl.setRenderTarget(textureB.current)
    gl.render(bufferScene, camera)
    gl.setRenderTarget(null)

    swap(textureA.current, textureB.current)

    finalQuad.current.map = textureB.current.texture
    bufferMaterial.current.uniforms.bufferTexture.value = textureB.current.texture

  })

  useFrame(({ mouse }) => {
    const m = [(mouse.x + 1)/2, (mouse.y + 1)/2]
    bufferMaterial.current.uniforms.mouse.value = m
  })

  const scale = useAspect("cover", window.innerWidth, window.innerHeight)

  return (
    <>
      {createPortal(
        <Plane scale={scale}>
          <bufferMaterial ref={bufferMaterial} />
        </Plane>
      , bufferScene)}
      <Plane scale={scale}>
        <meshBasicMaterial ref={finalQuad} />
      </Plane>
    </>
  );
}

export default Scene;
