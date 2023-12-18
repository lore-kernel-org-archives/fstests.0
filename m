Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7457346D
	for <fstests@vger.kernel.org>; Mon, 18 Dec 2023 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShGog51C"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ce28ac3cso10172275ad.0
        for <fstests@vger.kernel.org>; Mon, 18 Dec 2023 12:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702933062; x=1703537862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY+mEqC6GPt9lT2LFnDbQmPfKGyxE8/eZc8zVFMhEes=;
        b=ShGog51CP8NfkOFOoONR6MBXP1y/k1eTPuoRQxCE4+GzzamhOarO4W819Ul1uG06AW
         aOCrHwKVoHVWAh2+G3y2HUWeTvB3J+C8Ouc0MrjTPY4pFTXjlFmDsOTWQC5AonawgsAi
         CpcyPY99DZRLzs/bWgyGo4FFZrxRv8mo5aCD6yTY7UVADGfuQjZ4Td+lOFqQWWg+VKoa
         A3ZNk3Is9xkUm1v1jhnjFzldjkGPi4VCyqP1YumlQrKb5+4NvaxFSzGktQ/GwCW4s5FW
         3w+ElV3vCIXKan+NF6KuRPbXupvJme6qmZrjAnqqJVscq/6sxnhaHnU5kN+fYOHl5LeN
         /8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702933062; x=1703537862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iY+mEqC6GPt9lT2LFnDbQmPfKGyxE8/eZc8zVFMhEes=;
        b=to3supc4sDmP8LEz2f9PVzZ8Xn7i1bat+uimrOXVfUVUy6QCOZtwWHdnCf681dYWqU
         HfR0xF8YNcF4rek4cqGicINTx5XjZOn32pEXyDHXqqE1ZgbECCOOdCfAlZFM4yaTczFT
         fL10ZmIztzmU24eiFdZscYXJUjricyYvhMzjMn7iJu0gg/J/4QALIZm36DXfBZIrE3HB
         nCHzJMABbbCfahJZGgeGKR11T6a+/n9T/XndFrTa/QS2sJoAig96DE3ANDqYDaifbYH+
         3iPGzwWQxuZlI6zFZWWJ4GYnppBKYvMWDZGizV47l0eT98H8jafsyKGCZXQ+P4IkPxuY
         36HA==
X-Gm-Message-State: AOJu0YzQkFLnK6ZWZV5KV9MIrIMwv4sw4LxBZv32NMNyUxETXKLVaHiw
	avzxSDbA6wN0OcIERiup333m+gmj3J/KvA==
X-Google-Smtp-Source: AGHT+IFbTaIucmHCXBL44/ZMu/os+vcQCLCOCx/g9RiotMYy7JtbB/wyDqJzwvQlj9Q6vGYPZiQ2rg==
X-Received: by 2002:a17:902:9a46:b0:1d3:d9e3:2d9d with SMTP id x6-20020a1709029a4600b001d3d9e32d9dmr236907plv.126.1702933062314;
        Mon, 18 Dec 2023 12:57:42 -0800 (PST)
Received: from dell-laptop.lan ([180.190.183.136])
        by smtp.gmail.com with ESMTPSA id ix2-20020a170902f80200b001cffd42711csm4608224plb.199.2023.12.18.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:57:42 -0800 (PST)
From: Alexander Patrakov <patrakov@gmail.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	Alexander Patrakov <patrakov@gmail.com>
Subject: [PATCH v3] _require_sparse_files: rewrite as a direct test instead of a black list
Date: Tue, 19 Dec 2023 04:57:20 +0800
Message-ID: <20231218205720.3498-1-patrakov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAN_LGv2u5qRq_Zmp+qPGXz-PXdO7Bu33CKn+ycmQX1dzbDRFvw@mail.gmail.com>
References: <CAN_LGv2u5qRq_Zmp+qPGXz-PXdO7Bu33CKn+ycmQX1dzbDRFvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_require_sparse_files was implemented as a list of filesystems known not to
support sparse files, and therefore it missed some cases.

However, if sparse files do not work as expected during a test, the risk
is that the test will write out to the disk all the zeros that would
normally be unwritten. This amounts to at least 4 TB for the generic/129
test, and therefore there is a significant media wear-out concern here.

Adding more filesystems to the list of exclusions would not scale and
would not work anyway because CIFS backed by SAMBA is safe, while CIFS
backed by Windows Server 2022 is not (because the specific write
patterns found in generic/014 and generic/129 cause it to ignore the
otherwise-supported request to make a file sparse).

Mitigate this risk by rewriting the check as a small-scale test that
reliably triggers Windows misbehavior. The black list becomes unneeded
because the same test creates and detects non-sparse files on exfat and
hfsplus.

Signed-off-by: Alexander Patrakov <patrakov@gmail.com>
---
 common/rc | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index cc92fe06..a9e0ba7e 100644
--- a/common/rc
+++ b/common/rc
@@ -2870,17 +2870,30 @@ _require_fs_space()
 #
 # Check if the filesystem supports sparse files.
 #
-# Unfortunately there is no better way to do this than a manual black list.
+# Filesystems (such as CIFS mounted from a Windows server) that generally
+# support sparse files but are tricked into creating a non-sparse file by one
+# of the tests are treated here as not supporting sparse files. This special
+# treatment is done due to media wear-out concerns -- e.g., generic/129 would
+# write multiple terabytes of zeros if allowed to run on a filesystem that
+# ignores the request to make a file sparse.
 #
 _require_sparse_files()
 {
-    case $FSTYP in
-    hfsplus|exfat)
-        _notrun "Sparse files not supported by this filesystem type: $FSTYP"
-	;;
-    *)
-        ;;
-    esac
+    local testfile="$TEST_DIR/$$.sparsefiletest"
+    rm -f "$testfile"
+
+    # The write size and offset are specifically chosen to trick the Windows
+    # SMB server implementation into dishonoring the request to create a sparse
+    # file, while still fitting into the 64 kb SMB1 maximum request size.
+    # This also creates a non-sparse file on vfat, exfat, and hfsplus.
+    $XFS_IO_PROG -f -c 'pwrite -b 51200 -S 0x61 1638400 51200' "$testfile" >/dev/null
+
+    resulting_file_size_kb=$( du -sk "$testfile" | cut -f 1 )
+    rm -f "$testfile"
+
+    # The threshold of 1 MB allows for filesystems with such large clusters.
+    [ $resulting_file_size_kb -gt 1024 ] && \
+	_notrun "Sparse files are not supported or do not work as expected"
 }
 
 _require_debugfs()
-- 
2.43.0

