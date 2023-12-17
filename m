Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C50481DE
	for <fstests@vger.kernel.org>; Sun, 17 Dec 2023 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adft3CoP"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35d82fb7e86so8364675ab.2
        for <fstests@vger.kernel.org>; Sun, 17 Dec 2023 13:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702846873; x=1703451673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi7cdNzLt/wzo7SMRR3HSs5kjB2WiLF3Bjlw9aKfR+o=;
        b=Adft3CoP3u3AAdMw1DaZr9vJOWHfoiq4nbdNQk5xN6EoxH1t8eRbOeYGUaeegRbq3l
         fTHW9sRmX8SdgLLtGu8aLJiO1sGMaOV44DbmucHmLYPzmGZnmOppetp6h0i6D6x2cE1+
         zUufAlyB7NJ6yXuZ+i/MTCHhtWAw5MDRf0nT3O5qjJZC/sXBDMMkvFgESy+VDdZiQzHh
         zkVJ09ivC/U8J6dWpwo8aPRuNhplomR8f6nGBRfpgMclQguXmkKjfn4pDBMop/2EYNQo
         DtkIaQv5sUX/Gt6Xt35ZqKMIei00bXiRNkf1w6KqwaC8Ofsa36CFJsDou+XM5n7lQupi
         TA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702846873; x=1703451673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi7cdNzLt/wzo7SMRR3HSs5kjB2WiLF3Bjlw9aKfR+o=;
        b=Z70zqT2MmYdXzWxEnj2S6mHCoBEHwiAPm9mSLpV3RyDh+2ewfrD4kskVeN8wNq9dlr
         t4/I7ShXGyaSn2Nk3c7UyJcyEKMu7vSreuoVpG/TTT9dfJsRjIGFrISotpIO2jY+aSNX
         2SVdHT3/HSfovxZCx61C0YBJxOVLq5yAQZJ8fN8AjO/quGPsrepnrL6YCogf3fFcCy6o
         shUQDTwqUwBzMKI/73wtQs1TSqiVi2kwmMCHJFWLUkL6feqwTC0LSODwUTxB98PGJP0Y
         1fCl8qBU2zaa3YcwGrlCk2XexNA6D2OckcDXW6G9m1AqIqobHQS2xCKL+rohqH7wtOVT
         HolA==
X-Gm-Message-State: AOJu0YzlGyziH3qAmE54OwYObjAQ4mpABK/InyhNIvBq5GcPtR16DLNy
	2dOvmfm6yw9BMWecymg8mpmZSaXzp3pvaa7P
X-Google-Smtp-Source: AGHT+IGt1R8KnFNPt5XXxtcCGF9nSZFzFcH91UlVtl9PDXup4RvEiHiyBGTjf6sCZ9MDFcBgpUv6IQ==
X-Received: by 2002:a05:6e02:1d13:b0:35d:49b8:e08e with SMTP id i19-20020a056e021d1300b0035d49b8e08emr19015608ila.30.1702846873355;
        Sun, 17 Dec 2023 13:01:13 -0800 (PST)
Received: from dell-laptop.lan ([180.190.183.136])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b001cf65844874sm17616016plg.45.2023.12.17.13.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:01:12 -0800 (PST)
From: Alexander Patrakov <patrakov@gmail.com>
To: fstests@vger.kernel.org
Cc: Alexander Patrakov <patrakov@gmail.com>
Subject: [PATCH v2] _require_sparse_files: add a safeguard against media wearout
Date: Mon, 18 Dec 2023 05:00:53 +0800
Message-ID: <20231217210053.9180-1-patrakov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAN_LGv2UUOZvxN6w83tLudPZ5O9VPN0aJVDJay4rJDsvtcn29Q@mail.gmail.com>
References: <CAN_LGv2UUOZvxN6w83tLudPZ5O9VPN0aJVDJay4rJDsvtcn29Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_require_sparse_files is implemented as a list of filesystems known not to
support sparse files, and therefore it misses some cases.

However, if sparse files do not work as expected during a test, the risk
is that the test will write out to the disk all the zeros that would
normally be unwritten. This amounts to at least 4 TB for the generic/129
test, and therefore there is a significant media wearout concern here.

Adding more filesystems to the list of exclusions would not scale and
would not work anyway because CIFS backed by SAMBA is safe, while CIFS
backed by Windows Server 2022 is not.

In other words, Windows reserves the right to sometimes (!) ignore our
intent to create a sparse file.

More discussion: https://lore.kernel.org/fstests/20231206184759.GA3964019@frogsfrogsfrogs/T/#t

Mitigate this risk by doing a small-scale test that reliably triggers
Windows misbehavior and checking if the resulting file ends up being
not sufficiently sparse.

Signed-off-by: Alexander Patrakov <patrakov@gmail.com>
---
 common/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/rc b/common/rc
index cc92fe06..5d27602a 100644
--- a/common/rc
+++ b/common/rc
@@ -2871,6 +2871,12 @@ _require_fs_space()
 # Check if the filesystem supports sparse files.
 #
 # Unfortunately there is no better way to do this than a manual black list.
+# However, letting tests expand all the holes and write terabytes of zeros to
+# the media is also not acceptable due to wearout concerns.
+#
+# Note: even though CIFS supports sparse files, this test will mark it as
+# failing the requirement if we can coax the server into allocating and writing
+# the ranges where holes are expected. This happens with Windows servers.
 #
 _require_sparse_files()
 {
@@ -2881,6 +2887,23 @@ _require_sparse_files()
     *)
         ;;
     esac
+
+    local testfile="$TEST_DIR/$$.sparsefiletest"
+    rm -f "$testfile"
+
+    # A small-scale version of looptest - known to trigger Microsoft SMB server
+    # into the decision to write zeros to the disk. Also creates a non-sparse file
+    # on vfat.
+    # See also the discussion at https://lore.kernel.org/fstests/20231206184759.GA3964019@frogsfrogsfrogs/T/#t
+    $XFS_IO_PROG -f \
+	-c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 102400 102400' \
+	-c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 204800 102400' \
+	-c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 307200 102400' \
+	-c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 409600 102400' "$testfile" >/dev/null
+    resulting_file_size_kb=$( du -sk "$testfile" | cut -f 1 )
+    rm -f "$testfile"
+    [ $resulting_file_size_kb -ge 300 ] && \
+	_notrun "Sparse files do not work as expected, skipping test due to media wearout concerns"
 }
 
 _require_debugfs()
-- 
2.43.0

