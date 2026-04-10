Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32315284690
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827130; cv=none; b=uXiNKvQ+IWPSoUPMzTAGqdQ8CEypGHya3kXi30fYHrh2w4YBvTFrvGFJ0pdXyQNzwk5sEyf+pa4PwRHHBd+PhpsGs/2B6VCykSxUqydDvVrstyj3WubYp/ZNQ4Wp/yjWCjm66STd+eR9304Z18q4xdYztKgnidCp4EHWjCcF194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827130; c=relaxed/simple;
	bh=2aOjuGgHj23QGc9WZcqiALfM1qYxtlLXOY+c6zviAcs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ie203vRJWz2WHhSAydjKkfSl+kMJ1AFV+qRvWa/UyhC5WBzp0OBoHJqz9yJ+YrAniyYXqIUYo6/N4v6VYueGsfTh3GCcxaJVat6oK3Rmd9gMZAFXmUyZq7QHl66LT3yASp9kwEZ4jNKFqOBzR9l3/ojaLK9I8ELOS3DCM32nR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDx0DivL; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDx0DivL"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8704795d25so171116166b.2
        for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775827127; x=1776431927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XBHYGu/W+MllWbifwusYwjsWD3CeuSoNa462jWa12vA=;
        b=MDx0DivLOwGLT7vwcaMBdAjZfFxirrpRFT7rLtHW2O+beJt3/ccJdKjyghqVNnCaRg
         nUJAd1POvSPDbKaKc5n4IF4o/2ZjS5RN8GuJifFWzajNRobhc2Bi2+xjB4iaAT33SIK/
         6T7NGrMR7D2FkLHmS5RbSRkGeI5fCY4bpd8p4GVZJpaHw8sV4DuBmSt9UO/QGxj089+k
         91GNrFul4FQ4qChwalUxj+gnkYKVQCz1Zlw23zs718o0X2YL1dOHyFXTNcQp8UvV/sg+
         c0vHr7K/PpfpbDr/BWzxOECMRbiJ3H2b9tce/4Sb9oYvCwiQgdep4bKtHz68Bh/cex+R
         KZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775827127; x=1776431927;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBHYGu/W+MllWbifwusYwjsWD3CeuSoNa462jWa12vA=;
        b=O7uB+ZK68ltlhx6rXxAUue2DdQpLwxKr9p9FRRO6kT4+wbfn03OwgKpFSRMPwT/Hsa
         88109l6VSJYMFzj/TaB7K87aEuWJd5NcfGteJluNCWczF2MqD1pU/taYVmSeAyMhrMBF
         kXoP8kCuuT5tnhNr5YFtf+YtUJKZ0UdJX1qMP3aEETzagZqRH64F6LgUq5xq5dulq9xo
         4MvSZaKcXqjiblbX3XwCmgyvKveiFN6SV0N4EORLmkSoABl1Q36KWVo/R0Tdxd5P3TE0
         v+YcBe6K6eLDiL/1hCFJEfuHowPugkZIj4RoZZfEoN4wjMk9Ac2mJzYLNKeOxYx7uoOG
         OV5g==
X-Forwarded-Encrypted: i=1; AJvYcCVmleGAEd3FQbBWzFNjmxSqw0AkiwfK7IEid3I6MTpyK0/yXyLo9tENOgVsQ3U+ddkZE1vQPQ84@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LMDDxfaMLg5+uWJoLcXzbh+E3o/FNO2ZF/LkJtCX+7CyBdkE
	qJiVb2I4igZjs1YEVgofqLhF037UNWBRFCLtTtqRIQnWPrZBvYcBzzCuWN5Zvn+GNwS4VCSFM++
	gioy12K87PE+xSQjm3szV/ymE9XzV2Q==
X-Received: from ejcsa19.prod.google.com ([2002:a17:907:6d13:b0:b87:16d1:59a5])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c39a:b0:b97:aea3:86dc with SMTP id a640c23a62f3a-b9d727a0621mr177539466b.15.1775827127281;
 Fri, 10 Apr 2026 06:18:47 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:18:20 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410131821.991005-1-jprusakowski@google.com>
Subject: [PATCH] generic/050: handle f2fs as nojournal filesystem
From: Jan Prusakowski <jprusakowski@google.com>
To: zlang@kernel.org, fstests@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, anand.jain@oracle.com, 
	wqu@suse.com, Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

F2FS uses a checkpoint mechanism for metadata consistency rather than a
traditional journal. Roll-forward recovery is only needed if there are
fsync'd files since the last checkpoint.

In this test case, files are created without fsync, so there is no
roll-forward data to replay during mount.

Therefore, F2FS does not need to write to the device to recover, and
successfully mounts on the read-only block device. Thus, it should be
treated as nojournal in this case.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/050 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/generic/050 b/tests/generic/050
index 3bc37175..3a641a65 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -46,6 +46,18 @@ elif [ "$FSTYP" = "btrfs" ]; then
 	# So for this test case, btrfs will not get any dirty log tree thus
 	# it can be treated as "nojournal".
 	features="nojournal"
+elif [ "$FSTYP" = "f2fs" ]; then
+	# F2FS uses a checkpoint mechanism for metadata consistency rather than a
+	# traditional journal. Roll-forward recovery is only needed if there are
+	# fsync'd files since the last checkpoint.
+	#
+	# In this test case, files are created without fsync, so there is no
+	# roll-forward data to replay during mount.
+	#
+	# Therefore, F2FS does not need to write to the device to recover, and
+	# successfully mounts on the read-only block device. Thus, it should be
+	# treated as "nojournal" in this case.
+	features="nojournal"
 fi
 _link_out_file "$features"
 
-- 
2.53.0.1213.gd9a14994de-goog

