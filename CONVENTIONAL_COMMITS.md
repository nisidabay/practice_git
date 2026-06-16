# Conventional Commits

Una convención ligera sobre los mensajes de commit que hace el historial
legible a simple vista y permite automatizar versionado y changelogs.

## Formato

```
<tipo>(<ámbito opcional>): <descripción>

<cuerpo opcional>

<footer opcional>
```

La línea del título es obligatoria. Todo lo demás es opcional.

## Tipos

| Tipo | Significado | Versión |
|------|-------------|---------|
| `feat` | Nueva funcionalidad | minor |
| `fix` | Corrección de bug | patch |
| `BREAKING CHANGE` | Cambio incompatible (en el **footer** o añadiendo `!` tras el tipo) | major |
| `chore` | Mantenimiento (renombrar, mover, actualizar deps) | — |
| `docs` | Solo documentación | — |
| `refactor` | Cambio de código que no arregla nada ni añade nada | — |
| `style` | Formato, whitespace, lint (no confundir con CSS) | — |
| `test` | Añadir o corregir tests | — |
| `perf` | Mejora de rendimiento | — |
| `ci` | Cambios en CI/CD | — |
| `build` | Cambios en el sistema de build | — |

## Ejemplos

```bash
# Lo más básico
feat: add dark mode toggle

# Con ámbito
feat(auth): add OAuth2 login flow

# Breaking change (dos formas equivalentes)
feat!: drop support for Node 16

# o en el footer:
feat: drop support for Node 16

BREAKING CHANGE: Node 16 is no longer supported

# Con cuerpo (explica el por qué, no el qué)
fix: handle empty search results

The search endpoint returned 500 when the query was empty.
Now it returns an empty array with 200.

Closes #42

# Chore — tareas que no tocan código de producción
chore: update dependencies

# Docs — solo documentación
docs: fix typo in README

# Refactor — cambio sin efecto externo
refactor: extract validation logic to helper

# Test
test: add edge cases for empty input
```

## Cómo se relaciona con lo que practicas en este repo

Los conceptos de Git que practicas aquí (restore, revert, rebase, reflog...)
son el **motor**. Los Conventional Commits son el **lenguaje** con el que
escribes en el historial. Son ortogonales y complementarios.

Cuando hagas un `rebase -i` para reword o squash, los mensajes semánticos
te permiten ver de un vistazo qué hace cada commit:

```bash
# Antes del rebase — no se entiende nada
a1b2c3d wip
e4f5g6h more changes
i7j8k9l fix
m0n1o2p final version

# Después del rebase — historial limpio y legible
q1r2s3t feat: add search bar
u4v5w6x fix: handle empty search results
y7z8a9b refactor: extract pagination logic
```

## Herramientas que lo usan

- **`standard-version`** / **`semantic-release`** — versionado automático
  basado en los mensajes de commit.
- **`commitlint`** — valida que tus mensajes sigan el estándar.
- **`git log --oneline --grep`** — búsqueda rápida por tipo:

  ```bash
  git log --oneline --grep="^feat"
  git log --oneline --grep="^fix" --since="2024-01-01"
  ```

## Referencia oficial

<https://www.conventionalcommits.org/en/v1.0.0/>
