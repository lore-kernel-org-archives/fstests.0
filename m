From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 0/3] fstests: dirent file type tests
Date: Tue, 20 Dec 2016 15:17:32 +0200
Message-Id: <1482239855-791-1-git-send-email-amir73il@gmail.com>
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

generic/396 runs some tests on directory file types.

_supports_filetype() helper is used by this test
and by overlayfs to check for file type support of upper
dir fs.

Tested with tmpfs, ext2, ext4, xfs for d_type supported fs
and with xfs -m crc=0 -n ftype=0 for d_type unsupported fs

Tested that overlay tests run over tmpfs (generic ftype check)
Tested that overlay tests run over xfs (ftype=1)
Tested that overlay tests do not run over xfs (ftype=0)

v2:
- use helper to test for file type support
- allow DT_UNKNOWN type, but only for all files
- verify . and .. have DT_DIR type

v1:
- verify that d_type matches actual file type

Amir Goldstein (3):
  common/rc: factor out _supports_filetype() helper
  common/rc: add generic file type support check
  generic/396: test correct d_type values

 .gitignore            |   1 +
 common/rc             |  42 +++++++++++++-------
 src/Makefile          |   2 +-
 src/t_dir_type.c      | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/396     |  87 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/396.out |   9 +++++
 tests/generic/group   |   1 +
 7 files changed, 235 insertions(+), 15 deletions(-)
 create mode 100644 src/t_dir_type.c
 create mode 100755 tests/generic/396
 create mode 100644 tests/generic/396.out

-- 
2.7.4
