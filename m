Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C913BE14D
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740160; cv=none; b=bbcDORZGY84qGpPDp5vGWyhuVZv5h5WigO5q6QALAQO3wollrwCtKOjIMdn9okCaEjiNqbYEmIvEepXBpyrUo9dgLH3W/je5pV8zACgel2tICOTe+27vebJGLeEhUJ6RRpTX1hc3bXAn9XuIqXt49/lBqL2D7aASUGGEnRFlcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740160; c=relaxed/simple;
	bh=RJllLyCaPaWRPSYzENirEX4Cdgh5efPzES3jhjFUByo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VolCcM43pKAHlL4Elqy0ZI9HCVPNKzfmX+AFLO/ny+AL0fZ0byY/gRnqnPicMSESxtzzTAyVq459iB62L0rdmjT9HyUQ9YgNFW+tfgdBRkkeQUQ0vjBwLpM5vuyTMQEnUD5V34YAVHR3EcdHROLpKRX0RKhcYO6TEIAMF4ygEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwN6Sp+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwN6Sp+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECD11F000E9;
	Wed, 26 Aug 2026 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740159;
	bh=MdMPR9xxB+BXSpYhc6uIrvyWs25H0/C3zNLOlpuyTJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwN6Sp+M78LvuQEJVrswszVGgT2LDO1FTye6ctzoeffUZkoQ4zWoNPnpdWTFVn1KX
	 AYrimwVHStckJhwF/eunCPUtN7fV17vtTsawHH7XaZ/1SWNLlR3f511NPwlEJ+vg7o
	 2ABNZWytoxUifmERVYLN+Wc9yQGBMB1GBlKQjIPOxQfadOZYQhQNymxrOCZrJaLnrJ
	 FxkRS2S3IFvrxOTrSzA/7c8m5W+prNPsXkdwQE8RtxQXIJWL3kNsL27ikTD7xjj9+y
	 RSwe0WJvw/xd70cpC/Pn8dQuxNst3Hb+9PfFWEBE0DOy1juF3hZM1VhzkES3QpiNhq
	 eeSJuLhKh01VA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 4/4] check: add deprecated options warning
Date: Wed, 26 Aug 2026 18:28:57 +0800
Message-ID: <20260826102857.3224318-5-zlang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826102857.3224318-1-zlang@kernel.org>
References: <20260826102857.3224318-1-zlang@kernel.org>
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
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 check | 77 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/check b/check
index df209f1f..bca30215 100755
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
@@ -282,20 +290,61 @@ compat_old_option()
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
-		-\?)		check_args+=("--help") ;;
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
+		-\?)
+			check_args+=("--help")
+			deprecated_opt_warn "-\?" "-h or --help"
+			;;
+		*)
+			check_args+=("$1")
+			;;
 		esac
 		shift
 	done
-- 
2.55.0

