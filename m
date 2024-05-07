Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF220187326
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112542; cv=none; b=euHaC6Hpvpgy620yIFA0kD0A4+PVMFKpvJdF46US+flGcbSF13ZpCj2xCqh8Vbxa0E1sm3SnOOvEbcgmsHnRTXaazyIn3dH/kEY56K5MhNM5D9iLeqFu159LZGPrNkGAZvo4kFVPlj/ygfiaNO/vcBK1kArJVuchSGWShjNZ8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112542; c=relaxed/simple;
	bh=jZ3U1Q871r6OkJ2Njb2rrJaKylS3FSiliBkBOejtF3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bmbjtQOr3g3SwelrfcB4fSyJf91pTEovL+56UPBIyLE6v8QCVrKmkGRJ8JaRxg30I+866Wag0rZCi3aejQ4FEtKjSROwGX38M40BoOUhaobroiyjUuv1dpqsd1i5l+xhGpMYVHF4rcrcFBL9/0j8HMlZbYRc/bjRUk1bbeIGI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JJfTKXi2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JJfTKXi2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62026f59233so1151517b3.1
        for <fstests@vger.kernel.org>; Tue, 07 May 2024 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715112539; x=1715717339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tbIHQekgsaQ5/Cm+qVmozu3CZtSxRReTFO8xYZYOjVY=;
        b=JJfTKXi23o+uQz+jsDxDBMnQ1UynCX2Rc9MByTymj8mEJ6rukXpG5XY6sJzhryFdvZ
         Tv8GCzd6Gp/xLy3E6PXFSvC1zeHx7NSAMHf8qw+hDroz4g+KDdFATAtCSfy3hZtlfoAv
         ei76iLL9V4dkx+GAEfApy4OHDNJ2oNunQkhV9pbajq2JB3rJ2ZqcrTu5y9teMNCz++TQ
         2bD5LNunQxnFfSSvMzsGH7GQ3x23pqiSm74rhz73WjSS2dnBiXBvZQHFTpj4kO9rg5/2
         XSsP/cslqUl0Cz6zRSL8u3X3kj7rz8AOaWI4J0ji0NRpgh0OJdqj50DCI8/wWcobVeOU
         EmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715112539; x=1715717339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbIHQekgsaQ5/Cm+qVmozu3CZtSxRReTFO8xYZYOjVY=;
        b=Gvq/UKvMeBrEj3FqRwSZVPmp/iY4S0BD6o+bmZ50RSnOouuOz9B1IdqBQhOfNk1l9G
         Mgjz/PfWxwKYLCLDRMahaxHErbxXxEnQNbogCA8mt9OvEdWsD4bOQ4ijCTwAaYyI/wbP
         TEvTut+ndKIm2o1O3MaL1iJApQ9lON7FGsIrT0rEeUf+pbabhsBYPn4MXFlv36PjkN20
         bpBoJ5aAn4WSgfJMGbTjhZnPQ30X+erXMb11xpYEywThkLKr534Jhp9iPnAcwT163x9+
         AJHWNvn4uC3zYpy5+piOHMXFZiKiRxCuYsTPnXQEpwn86t1HrnabL8XbXeKF1FD/sYMK
         Lsxg==
X-Gm-Message-State: AOJu0Ywl0ARV85SVs09KJT/LcHAoalmHrJHvoianHkUJdFwAfjUb+dv9
	7WXIRQPYtSxsXGAuUDo9hFnIqIj1s3vUyvwhEumkqWo19bTrcOKBUbg4IxsApyArBt9/ylgREN7
	V
X-Google-Smtp-Source: AGHT+IGgb89OtzaPXuT0sJCrOv/hOba8x4kDLz1fk/CrBUZiBSX6TF+HlydZP4MRPw5Xwu38SsP+7w==
X-Received: by 2002:a81:4f58:0:b0:614:35a7:4c40 with SMTP id 00721157ae682-620766308a9mr26624847b3.22.1715112538188;
        Tue, 07 May 2024 13:08:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v67-20020a814846000000b0061b8e9593d4sm2912170ywa.3.2024.05.07.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 13:08:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] fstests: mkfs the scratch device if we have missing profiles
Date: Tue,  7 May 2024 16:08:53 -0400
Message-ID: <adcf935ecd3d44957ee244b91790ee7b73df134b.1715112528.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a btrfs config where I specifically exclude raid56 testing, and
this resulted in btrfs/011 failing with an inconsistent file system.
This happens because the last test we run does a btrfs device replace of
the $SCRATCH_DEV, leaving it with no valid file system.  We then skip
the remaining profiles and exit, but then we go to check the device on
$SCRATCH_DEV and it fails because there is no file system.

Fix this to re-make the scratch device if we skip any of the raid
profiles.  This only happens in the case of some idiot user configuring
their testing in a special way, in normal runs of this test we'll never
re-make the fs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/011 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index d8b5a978..b8c14f3b 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -257,6 +257,12 @@ for t in "-m single -d single:1 no 64" \
 	workout_option=${t#*:}
 	if [[ "${_btrfs_profile_configs[@]}" =~ "${mkfs_option/ -M}"( |$) ]]; then
 		workout "$mkfs_option" $workout_option
+	else
+		# If we have limited the profile configs we could leave
+		# $SCRATCH_DEV in an inconsistent state (because it was
+		# replaced), so mkfs the scratch device to make sure we don't
+		# trip the fs check at the end.
+		_scratch_mkfs > /dev/null 2>&1
 	fi
 done
 
-- 
2.43.0

