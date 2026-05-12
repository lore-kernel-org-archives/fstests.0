Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1D3812F0
	for <fstests@vger.kernel.org>; Tue, 12 May 2026 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592369; cv=none; b=KinA945DQdZMee2i71jW2tUW+B/19qHf4dvmqeP6rn426clskGl8zKOdOvyshma2UFwc0dIvUc4wjUVGda0CmiQXuKKHarV0AjHM0tKRZws99Twm/NGYlkG6KezY/0/HZZc+DmRgxu7st84EBKZTQ0TnwcaTu7n2eiMcuLmBcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592369; c=relaxed/simple;
	bh=0+GIMT0G/ClbckSYau+nyyDMXXv4367figdzZiOiNG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2/LO+1x+H1gr/GpfBurlaJG6xjBhvoHe4pMamY8AcIh2kYWakDay9DGo32ZcAm3IeyDfvOcRNfovEfza00PCEAMf2SgRJTEeBCV6+L0bBDopM+RG6tjD392JUtpXfzzMpOgB1h0O/QGyi4kmHQV5wiprnP+XdjhXgYDpjDo42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezAz5vHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezAz5vHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7ABC2BCFC;
	Tue, 12 May 2026 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592368;
	bh=0+GIMT0G/ClbckSYau+nyyDMXXv4367figdzZiOiNG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezAz5vHcYaNrybWN+uqJBiC7hHz6Vt7YESQeCR/oqJkuV0WsidMIVt0xpPNsgWpQa
	 Hsx1ok0Kw+wllNbrtF81l8SUqt+q+3XhhH0Jh6+kEHRyKtSUqcOrtVeyfCFWLTm9qC
	 b3YI9R9+8aVAYfej65FBVEy4twmSwwvJ08JuBBs9hES/P5YZhBcfohJXVa0hesSVBY
	 DbRdvk3pKZ8jgC3zj0ZydrUXukRWOgHCa0Zmv3oPoL8gPUfx434e+AguR4o9a5HvJy
	 NowYM1Hgm/GpoiUwNiMzbzIstLEir0o8HoqOV7FbR4v0Hd+ts9GTVqgNyoRQcbmc/I
	 8xOW8i2IarU8Q==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [RFC PATCH 4/4] check: add deprecated options warning
Date: Tue, 12 May 2026 21:25:39 +0800
Message-ID: <20260512132539.931482-5-zlang@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512132539.931482-1-zlang@kernel.org>
References: <20260512132539.931482-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To notify xfstests users of deprecated options, add a warning which
does not interfere with test results or golden output.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 check | 72 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 13 deletions(-)

diff --git a/check b/check
index d19498e6..012b566c 100755
--- a/check
+++ b/check
@@ -275,6 +275,14 @@ _prepare_test_list()
 	rm -f $tmp.list
 }
 
+deprecated_opt_warn()
+{
+	local old=$1
+	shift
+
+	echo "[WARN] $old is deprecated, replace it with $*"
+}
+
 # Backward compatible with the old options mode. Translate word-style options
 # that getopt would misinterpret into long options.
 compat_old_option()
@@ -282,19 +290,57 @@ compat_old_option()
 	check_args=()
 	while [ $# -gt 0 ]; do
 		case "$1" in
-		-nfs)		check_args+=("--fs" "nfs") ;;
-		-afs)		check_args+=("--fs" "afs") ;;
-		-glusterfs)	check_args+=("--fs" "glusterfs") ;;
-		-cifs)		check_args+=("--fs" "cifs") ;;
-		-9p)		check_args+=("--fs" "9p") ;;
-		-fuse)		check_args+=("--fs" "fuse") ;;
-		-virtiofs)	check_args+=("--fs" "virtiofs") ;;
-		-pvfs2)		check_args+=("--fs" "pvfs2") ;;
-		-tmpfs)		check_args+=("--fs" "tmpfs") ;;
-		-ubifs)		check_args+=("--fs" "ubifs") ;;
-		-overlay)	check_args+=("--fs" "overlay") ;;
-		-udiff)		check_args+=("--udiff") ;;
-		*)		check_args+=("$1") ;;
+		-nfs)
+			check_args+=("--fs" "nfs")
+			deprecated_opt_warn "-nfs" "--fs nfs"
+			;;
+		-afs)
+			check_args+=("--fs" "afs")
+			deprecated_opt_warn "-afs" "--fs afs"
+			;;
+		-glusterfs)
+			check_args+=("--fs" "glusterfs")
+			deprecated_opt_warn "-glusterfs" "--fs glusterfs"
+			;;
+		-cifs)
+			check_args+=("--fs" "cifs")
+			deprecated_opt_warn "-cifs" "--fs cifs"
+			;;
+		-9p)
+			check_args+=("--fs" "9p")
+			deprecated_opt_warn "-9p" "--fs 9p"
+			;;
+		-fuse)
+			check_args+=("--fs" "fuse")
+			deprecated_opt_warn "-fuse" "--fs fuse"
+			;;
+		-virtiofs)
+			check_args+=("--fs" "virtiofs")
+			deprecated_opt_warn "-virtiofs" "--fs virtiofs"
+			;;
+		-pvfs2)
+			check_args+=("--fs" "pvfs2")
+			deprecated_opt_warn "-pvfs2" "--fs pvfs2"
+			;;
+		-tmpfs)
+			check_args+=("--fs" "tmpfs")
+			deprecated_opt_warn "-tmpfs" "--fs tmpfs"
+			;;
+		-ubifs)
+			check_args+=("--fs" "ubifs")
+			deprecated_opt_warn "-ubifs" "--fs ubifs"
+			;;
+		-overlay)
+			check_args+=("--fs" "overlay")
+			deprecated_opt_warn "-overlay" "--fs overlay"
+			;;
+		-udiff)
+			check_args+=("--udiff")
+			deprecated_opt_warn "-udiff" "--udiff"
+			;;
+		*)
+			check_args+=("$1")
+			;;
 		esac
 		shift
 	done
-- 
2.54.0

