Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630422DFA6
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587845; cv=none; b=g0KNum5VjdRRpGZT3k1dJ1LE88XIv7Z6rRrc9xVdmjlywA0S663WD3j6TS2jnLhEizVarkh+BtiK2xQEjzBx4ks+oBw4F2Dr+6ost2KqxyD9Mg2C87DVbkKNMTiqF0Jz6twoVrLiCp6kikTZtun38fJ06xUl4MrbNn92DvTUvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587845; c=relaxed/simple;
	bh=jNgyZxO9A+l2JdrShQckRPUZuul6lHTx+ihD3Y7hres=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxeA11zmfYXF2AFlLOVfj+UMTMURed0gaiOKKjoJtkxLJFBsWiWYGhaBTOBMgCM0m+Uui/qKXnbLFjcop96EK+kEcBX7qdqG/9ow69XSTHGVdswTe12EeM0LcAZse/9lx/QeZyv+JUeofUAoGjBEgWTg49F2AXLxEZkNVb+ttUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGx/Ib/u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGx/Ib/u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742587842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2yNrLrdysZxKhumWEKLo/UcZEKdD/wlJuzaYsbS7Uc=;
	b=EGx/Ib/uL3ZedkNCkgwzPe6t+WKMtJzIRe+tDPLGRVtXH+ShJW53DGq3fahvZ96auzODxO
	sRmTLw5iDZPJxLrjc2fL5sGMrk8YWd1usGaxYK6bzbONIwmscN8jDGdtYHWAM8AAvok5oh
	btSxrmjZgZ3XD2LGYEvKexV4N/yog1c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-3gNJahlTNyyNkxi-gOYCxQ-1; Fri, 21 Mar 2025 16:10:40 -0400
X-MC-Unique: 3gNJahlTNyyNkxi-gOYCxQ-1
X-Mimecast-MFC-AGG-ID: 3gNJahlTNyyNkxi-gOYCxQ_1742587840
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab39f65dc10so247609066b.1
        for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 13:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742587839; x=1743192639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2yNrLrdysZxKhumWEKLo/UcZEKdD/wlJuzaYsbS7Uc=;
        b=T7d4UyoB4pb5973imaGMfKB4IOvKABGulBaNOre5JhSuFeTUbVRSAd9bTNWxDmHjKY
         b4mqAwYYDPccxZ004PDvh4yBXTgECmc4KDuXfsrQ8wvVNjtJxEwojtWxfymgIIq/+H/v
         EZWnUH97yGf7pVVYQCTaW1lZ7PXriPf8rG5Dy6wpeh1YwMFNv3Oi2gEh0lu/x+GNlhHA
         0wjSZ2w2oWXryxf99c/632mBnDpreeLsnPyTAy0mscDmY1saKOiokVu4+q7kKDdbKeEt
         zEF+75Om9YGTOEciwbhEIihQCtGWNFYQG8mFB7TAbdVK867Bnu9K9eXSp516yQeajrKh
         3Liw==
X-Gm-Message-State: AOJu0YzExK8cbb7vNrapQFoRlV9HzmXGiGCnfDbgUgxDe9DwWNDbJZFF
	HTUKa86vhrJ9vXFodn7qYZq347GPZAOSi0rMKRbPK4u0Hn0MCXGVxFA3Rshe3WOaR4nu5cNJLhC
	W91BvokNeHDCUtVmKynZJzUjmhzGqOawQPSir2HtmgQ+HlxC3iV4NOg==
X-Gm-Gg: ASbGncs3RrkjjXAsaugmP4Ux+NiD9tmchxsgpjyGodBnm7kwMo9Gv1unuC9EVJNCA8q
	KrtU/SvXD1iDFmrKQoZUp4XVyjG5vwLZV3JS7fSvKSUysFFz+wrpRbEBny+aMq5/+rcj970MSOb
	gF2OqQo15IkWGsYQhvAbYm2r/QW4mXRZZxnqXeOVCf+KyuHWHkJPl0GRZ0ieWkn43FPQ+rWaU5D
	sw4dpjunUhs5Zk7oBJfjVx5deNLdofDAFBT5uLcPgtjfgh8TDzDpWJ+Ox3n1LMEupSRpB8dox7G
	pp5Z2Qs9m/C0RpTH8lMiqccxc14mFU0eEmg=
X-Received: by 2002:a17:906:6a21:b0:abf:19ac:771 with SMTP id a640c23a62f3a-ac3f2080896mr475635866b.2.1742587839019;
        Fri, 21 Mar 2025 13:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZmiJecqRwfDq+ADSODPmDWs6rmmd38UoMe4jbsL1oTfGUria4/tRYE4DaCZH9Opi9M0QjTw==
X-Received: by 2002:a17:906:6a21:b0:abf:19ac:771 with SMTP id a640c23a62f3a-ac3f2080896mr475632666b.2.1742587838412;
        Fri, 21 Mar 2025 13:10:38 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8676c2sm205433466b.9.2025.03.21.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:10:37 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 21 Mar 2025 21:10:37 +0100
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 1/2] fsxattrat: introduce program to set/get fsxattr
Message-ID: <20250321-xattrat-syscall-v1-1-366175071708@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9127; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=FdNFYDMWaF5ncCiY2zypobImgNr1n2QyPdI/khvi1cg=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0u8eeWRnVNpXWL7j0rK+9Q3P2FQ4FivtTIi2LPlq9
 iK/M2nG96UdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJnLyKSPDZqULVx+JsyeI
 73TK/29z/ZpsiOPSolk3ZAqZ/Lj2GZYsZGQ44eJzT4cleLLrhyndB6WfbH96Xda57H2ZgZH1swV
 yPXyMABqxSA8=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108
References: <20250321-xattrat-syscall-v1-0-366175071708@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-xattrat-syscall-v1-0-366175071708@kernel.org>

This programs uses newly introduced getfsxattrat and setfsxattrat
syscalls. These syscalls comparing to FS_IOC_SETFSXATTR can work
with special files via *at() semantic.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 .gitignore            |   1 +
 configure.ac          |   1 +
 include/builddefs.in  |   1 +
 m4/package_libcdev.m4 |  16 ++++
 src/Makefile          |   4 +
 src/fsxattrat.c       | 246 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 269 insertions(+)

diff --git a/.gitignore b/.gitignore
index cce0795ea81878e88957324377b81051905471a6..9127af3c6bec0991300ec729ba09400f05c3b118 100644
--- a/.gitignore
+++ b/.gitignore
@@ -212,6 +212,7 @@ tags
 /src/fiemap-fault
 /src/min_dio_alignment
 /src/dio-writeback-race
+/src/fsxattrat
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/configure.ac b/configure.ac
index f3c8c643f0eb9e72183ed17b5eb9a63c33d8bbe7..be2072c2caf4cb65a1ee37b15ec62048a1bef21b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,6 +73,7 @@ AC_HAVE_RLIMIT_NOFILE
 AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
 AC_HAVE_FICLONE
 AC_HAVE_TRIVIAL_AUTO_VAR_INIT
+AC_HAVE_FSXATTRAT
 
 AC_CHECK_FUNCS([renameat2])
 AC_CHECK_FUNCS([reallocarray])
diff --git a/include/builddefs.in b/include/builddefs.in
index 96d5ed25b3e2d4cfc826f3470e69603550054ce7..533848c2b45e24f5ee9ef39e719f5199e5e73034 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -74,6 +74,7 @@ HAVE_BMV_OF_SHARED = @have_bmv_of_shared@
 HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
 NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
 HAVE_FICLONE = @have_ficlone@
+HAVE_FSXATTRAT = @have_fsxattrat@
 
 GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
 SANITIZER_CFLAGS += @autovar_init_cflags@
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index ed8fe6e32ae00aea9571fff13362754111ecca71..7b828c647dc54f059a6a8571cb858d5b6dfb5405 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -86,3 +86,19 @@ AC_DEFUN([AC_HAVE_TRIVIAL_AUTO_VAR_INIT],
     CFLAGS="${OLD_CFLAGS}"
     AC_SUBST(autovar_init_cflags)
   ])
+
+#
+# Check if we have a getfsxattrat/setfsxattrat system call (Linux)
+#
+AC_DEFUN([AC_HAVE_FSXATTRAT],
+  [ AC_MSG_CHECKING([for getfsxattrat/setfsxattrat])
+    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#include <sys/syscall.h>
+#include <unistd.h>
+    ]], [[
+         syscall(__NR_getfsxattrat, 0, 0, 0, 0, 0, 0);
+    ]])],[have_fsxattrat=yes
+       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
+    AC_SUBST(have_fsxattrat)
+  ])
diff --git a/src/Makefile b/src/Makefile
index 6ac72b3662570dd9bbcb90d4b23df931b7cd5b9e..365e324d91eb828ffa42d515ee49a842044d6267 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -61,6 +61,10 @@ ifeq ($(HAVE_FALLOCATE), true)
 LCFLAGS += -DHAVE_FALLOCATE
 endif
 
+ifeq ($(HAVE_FSXATTRAT), yes)
+LINUX_TARGETS += fsxattrat
+endif
+
 ifeq ($(PKG_PLATFORM),linux)
 TARGETS += $(LINUX_TARGETS)
 endif
diff --git a/src/fsxattrat.c b/src/fsxattrat.c
new file mode 100644
index 0000000000000000000000000000000000000000..a339de66381ee361dfda5bcb598440a31c5f35b5
--- /dev/null
+++ b/src/fsxattrat.c
@@ -0,0 +1,246 @@
+#include "global.h"
+#include <sys/syscall.h>
+#include <getopt.h>
+#include <errno.h>
+#include <linux/fs.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <getopt.h>
+#include <stdlib.h>
+
+#if !defined(SYS_getfsxattrat) && defined(__x86_64__)
+#define SYS_getfsxattrat 467
+#define SYS_setfsxattrat 468
+#endif
+
+#define SPECIAL_FILE(x) \
+	   (S_ISCHR((x)) \
+	|| S_ISBLK((x)) \
+	|| S_ISFIFO((x)) \
+	|| S_ISLNK((x)) \
+	|| S_ISSOCK((x)))
+
+static struct option long_options[] = {
+	{"set",		no_argument,	0,	's' },
+	{"get",		no_argument,	0,	'g' },
+	{"no-follow",	no_argument,	0,	'n' },
+	{"at-cwd",	no_argument,	0,	'a' },
+	{"set-nodump",	no_argument,	0,	'd' },
+	{0,		0,		0,	0 }
+};
+
+static struct xflags {
+	uint	flag;
+	char	*shortname;
+	char	*longname;
+} xflags[] = {
+	{ FS_XFLAG_REALTIME,		"r", "realtime"		},
+	{ FS_XFLAG_PREALLOC,		"p", "prealloc"		},
+	{ FS_XFLAG_IMMUTABLE,		"i", "immutable"	},
+	{ FS_XFLAG_APPEND,		"a", "append-only"	},
+	{ FS_XFLAG_SYNC,		"s", "sync"		},
+	{ FS_XFLAG_NOATIME,		"A", "no-atime"		},
+	{ FS_XFLAG_NODUMP,		"d", "no-dump"		},
+	{ FS_XFLAG_RTINHERIT,		"t", "rt-inherit"	},
+	{ FS_XFLAG_PROJINHERIT,		"P", "proj-inherit"	},
+	{ FS_XFLAG_NOSYMLINKS,		"n", "nosymlinks"	},
+	{ FS_XFLAG_EXTSIZE,		"e", "extsize"		},
+	{ FS_XFLAG_EXTSZINHERIT,	"E", "extsz-inherit"	},
+	{ FS_XFLAG_NODEFRAG,		"f", "no-defrag"	},
+	{ FS_XFLAG_FILESTREAM,		"S", "filestream"	},
+	{ FS_XFLAG_DAX,			"x", "dax"		},
+	{ FS_XFLAG_COWEXTSIZE,		"C", "cowextsize"	},
+	{ FS_XFLAG_HASATTR,		"X", "has-xattr"	},
+	{ 0, NULL, NULL }
+};
+
+static int
+getfsxattrat(
+		int		dfd,
+		const char	*filename,
+		struct fsxattr	*fsx,
+		size_t		usize,
+		unsigned int	at_flags)
+{
+	return syscall(SYS_getfsxattrat, dfd, filename, fsx, usize, at_flags);
+}
+
+static int
+setfsxattrat(
+		int		dfd,
+		const char	*filename,
+		struct fsxattr	*fsx,
+		size_t		usize,
+		unsigned int	at_flags)
+{
+	return syscall(SYS_setfsxattrat, dfd, filename, fsx, usize, at_flags);
+}
+
+void
+printxattr(
+	uint		flags,
+	int		verbose,
+	int		dofname,
+	const char	*fname,
+	int		dobraces,
+	int		doeol)
+{
+	struct xflags	*p;
+	int		first = 1;
+
+	if (dobraces)
+		fputs("[", stdout);
+	for (p = xflags; p->flag; p++) {
+		if (flags & p->flag) {
+			if (verbose) {
+				if (first)
+					first = 0;
+				else
+					fputs(", ", stdout);
+				fputs(p->longname, stdout);
+			} else {
+				fputs(p->shortname, stdout);
+			}
+		} else if (!verbose) {
+			fputs("-", stdout);
+		}
+	}
+	if (dobraces)
+		fputs("]", stdout);
+	if (dofname)
+		printf(" %s ", fname);
+	if (doeol)
+		fputs("\n", stdout);
+}
+
+int main(int argc, char *argv[])
+{
+	int error;
+	int c;
+	const char *path = NULL;
+	const char *path1 = NULL;
+	const char *path2 = NULL;
+	unsigned int at_flags = 0;
+	unsigned int fsx_xflags = 0;
+	int action = 0; /* 0 get; 1 set */
+	struct fsxattr fsx = { 0 };
+	struct stat status;
+	int fd;
+	int at_fdcwd = 0;
+
+        while (1) {
+            int option_index = 0;
+
+            c = getopt_long_only(argc, argv, "", long_options, &option_index);
+            if (c == -1)
+                break;
+
+            switch (c) {
+	    case 's':
+		action = 1;
+		break;
+	    case 'g':
+		action = 0;
+		break;
+	    case 'n':
+		at_flags |= AT_SYMLINK_NOFOLLOW;
+		break;
+	    case 'a':
+		at_fdcwd = 1;
+		break;
+	    case 'd':
+		fsx_xflags |= FS_XFLAG_NODUMP;
+		break;
+	    default:
+		goto usage;
+            }
+        }
+
+	if (!path1 && optind < argc)
+		path1 = argv[optind++];
+	if (!path2 && optind < argc)
+		path2 = argv[optind++];
+
+	if (!path1)
+		goto usage;
+
+	if (at_fdcwd) {
+		fd = AT_FDCWD;
+		path = path1;
+	} else if (!path2) {
+		error = stat(path1, &status);
+		if (error) {
+			fprintf(stderr,
+"Can not get file status of %s: %s\n", path1, strerror(errno));
+			return error;
+		}
+
+		if (SPECIAL_FILE(status.st_mode)) {
+			fprintf(stderr,
+"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
+			return errno;
+		}
+
+		fd = open(path1, O_RDONLY);
+		if (fd == -1) {
+			fprintf(stderr, "Can not open %s: %s\n", path1,
+					strerror(errno));
+			return errno;
+		}
+		at_flags |= AT_EMPTY_PATH;
+	} else {
+		fd = open(path1, O_RDONLY);
+		if (fd == -1) {
+			fprintf(stderr, "Can not open %s: %s\n", path1,
+					strerror(errno));
+			return errno;
+		}
+		path = path2;
+	}
+
+	if (action) {
+		error = getfsxattrat(fd, path, &fsx, sizeof(struct fsxattr),
+				at_flags);
+		if (error) {
+			fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
+					strerror(errno));
+			return error;
+		}
+
+		fsx.fsx_xflags |= fsx_xflags;
+
+		error = setfsxattrat(fd, path, &fsx, sizeof(struct fsxattr),
+				at_flags);
+		if (error) {
+			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
+					strerror(errno));
+			return error;
+		}
+	} else {
+		error = getfsxattrat(fd, path, &fsx, sizeof(struct fsxattr),
+				at_flags);
+		if (error) {
+			fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
+					strerror(errno));
+			return error;
+		}
+
+		if (path2)
+			printxattr(fsx.fsx_xflags, 0, 1, path, 0, 1);
+		else
+			printxattr(fsx.fsx_xflags, 0, 1, path1, 0, 1);
+	}
+
+	return error;
+
+usage:
+	printf("Usage: %s [options]\n", argv[0]);
+	printf("Options:\n");
+	printf("\t--get\t\tget filesystem inode attributes\n");
+	printf("\t--set\t\tset filesystem inode attributes\n");
+	printf("\t--at-cwd\t\topen file at current working directory\n");
+	printf("\t--no-follow\t\tdon't follow symlinks\n");
+	printf("\t--set-nodump\t\tset FS_XFLAG_NODUMP on an inode\n");
+
+	return 1;
+}

-- 
2.47.2


-- 
- Andrey

