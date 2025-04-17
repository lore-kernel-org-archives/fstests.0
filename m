Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0F1CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860559; cv=none; b=r0gHQLVY6BDrGLeXfcOYUi8KgR0T9EF+0LMOn/B4zShkZUPrCJ6wfonqaY/ZrGmcyr5MlmOcrEN2SpwCnFhYhXdLUUDRhuuowLRixs/yADVEfCX4cdd8CrCRmH0h1AegQQsOg5hRHSvdL+yXa+IevJwa+Eh3CH+uqfMCLn0tSN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860559; c=relaxed/simple;
	bh=5KFbKijSv9OcImsDr4jbvhfLy0WUBaArtq6AKnsbfW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpPzeBtA4srKMq/CjIHOVz2kNzcFhs00QgQPDGpOlsesUpX1z5us9uwiZVBDxbV1YB8jZWSENHXI9XemIUH0OzI39re3Lb5bIL7VwU5KUM5N3zu+OeGtcs/tg0t0U6BBxyRrgm93FBCAHx8QU4Dd7ruaHorIREUw04OTioauYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=drZP70uY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="drZP70uY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-306b78ae2d1so201635a91.3
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860558; x=1745465358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqjb1ZjUlXSZHygPjJDDy1isndhaK5r2IQJwFDFVpkQ=;
        b=drZP70uYrCkg2gt9a3RCIfunQqE7wli0hCu0NprkVn+ywb4cA71ZmrsYpibs7jN4Qq
         hK+mP7IzEGw5aHzk+V2irjrvBxySUHvfJUtzzystgVIDCZ3+pvJIs/sEpWYtGnuQ4M0V
         MDGEi51mZ+PTARjFYCz4dfExo8+zD8tn19XBg6Zj6lo1vomL0aypKLEEmX7nFJ72XcAn
         LERzXUdlacPP6uQZcT4Ihna8wtdGKa/w8E/6Jx+hZI25F+wUbMLrUw+QRn6DAPEp6A4A
         ZoEXNqxdVm6k6TVKLOK5ZknQRpWFIcOvXpee0WZmPNjazsWpE6rvq1J7akL2DDSceJfJ
         tnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860558; x=1745465358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xqjb1ZjUlXSZHygPjJDDy1isndhaK5r2IQJwFDFVpkQ=;
        b=vyI6r0F7MgdojHpdBRzIgWlr5yMkuJnmBQUN+xUtI3aD343cUlDbIhf1vAcSf26597
         esScV/W6EkzZv/Ctql7pmY/jdmvQ9N6S/0j3BWPPEmnsmE29CL63MGt0aWlxG4jBkXFB
         TTt9ctcRIzF+pIbyUjcwqSCuoxFFBT3Q1pJBTwXxDjQdVg6tELjYkHH3tgpdxfAt55xw
         Wc3aX3Sy7n1nWHbv2gTyZ5mRsF0ulHsbRtiL3CwXpzobJeuzeyUlJZD29UvUYnlfAFr3
         EEwJL1qc29F1gr+Ihzb/9GjNb3kHR4UCRJAfdtFx6DuGLbTuy0PFf6BJ02VABqSCb3kt
         IFtA==
X-Gm-Message-State: AOJu0YyQQzRxeapcORgcPtZRvdholMQOKSMUzUTht54OfPZXKKBw33sO
	JOBshCU7XGVJYVqfHSyMifzPqmNEl5SMDTOB2ccGqURkkW1B8lcHO9S0j+a7L2cBvf8n78FchtN
	x
X-Gm-Gg: ASbGnctgaDC2zp5MFzeme13DGmwurzCUgVCiZJTqhC+97p8l29c0Z8ttyW27TKavza+
	7WW8584sxg3NQ/skc3a0HyFm9uX3PU1rIuePW5yW9k8+X10B+MNku6VGn9Jv2LJ8XYjsaZdWr1b
	VACgry0yZWbmuUUoNTRHBBgvXKe5JtdLcWFAi/2di9nRY7Ks1sFtT6YpTKBq3aTR4/N26lbNx3o
	vsQxOx8yEd2RiJvc0m6u+7UR7N1flDCEd1qCwSc7tnDsCRdvZcsj6qb2ZuPrnXPEUm7u/F0weBJ
	vuDiKI1ZKMDLgfAfr3KD31vk9ZdUGXxfT/StJpLu1eKq7iC+rHqDaBK9JDrng9lZIgW/+1SzJ1q
	9e6gGM3uoNMUe
X-Google-Smtp-Source: AGHT+IGcnssuUpp1zOcHWkM3OLAvJUtmFlXDXkCBENSL9w6GkoLVPr+IdUapG5XxIK8xeue+mjSHCw==
X-Received: by 2002:a17:90b:4ac3:b0:2f9:d9fe:e72e with SMTP id 98e67ed59e1d1-30863f2f794mr7181170a91.16.1744860557692;
        Wed, 16 Apr 2025 20:29:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861364d3fsm2450490a91.41.2025.04.16.20.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:17 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffd-00000009Y9N-3sB8;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mDx-0Urd;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 01/28] fstests: remove support for non-numeric test names
Date: Thu, 17 Apr 2025 13:00:42 +1000
Message-ID: <20250417031208.1852171-2-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

We haven't had any tests using the "999-the-mark-of-fstests" name
format for a long time. Th eonly test that used this format was
xfs/191-input-validation, and that got removed in 2022 by commit
c1941d6f5 ("xfs/191: remove broken test").

However, the infrastructure for this naming convention still exists,
so lets get rid of that dead code so we don't have to carry it
anymore.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check             | 15 ---------------
 common/test_names |  8 +-------
 new               | 24 ------------------------
 3 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/check b/check
index 9451c350b..d6bab8b5f 100755
--- a/check
+++ b/check
@@ -856,21 +856,6 @@ function run_section()
 	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
 		seq="${_list[$ix]}"
 
-		if [ ! -f $seq ]; then
-			# Try to get full name in case the user supplied only
-			# seq id and the test has a name. A bit of hassle to
-			# find really the test and not its sample output or
-			# helping files.
-			bname=$(basename $seq)
-			full_seq=$(find $(dirname $seq) -name $bname* -executable |
-				awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
-				     END { print shortest }')
-			if [ -f $full_seq ] && \
-			   [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
-				seq=$full_seq
-			fi
-		fi
-
 		# the filename for the test and the name output are different.
 		# we don't include the tests/ directory in the name output.
 		export seqnum=${seq#$SRC_DIR/}
diff --git a/common/test_names b/common/test_names
index 98af40cdb..b18fc9e36 100644
--- a/common/test_names
+++ b/common/test_names
@@ -2,11 +2,5 @@
 
 # Valid test names start with 3 digits "NNN":
 #  "[0-9]\{3\}"
-# followed by an optional "-":
-#  "-\?"
-# followed by an optional combination of alphanumeric and "-" chars:
-#  "[[:alnum:]-]*"
-# e.g. 999-the-mark-of-fstests
-#
 VALID_TEST_ID="[0-9]\{3\}"
-VALID_TEST_NAME="$VALID_TEST_ID-\?[[:alnum:]-]*"
+VALID_TEST_NAME="$VALID_TEST_ID"
diff --git a/new b/new
index 6b50ffeda..c786a9dbb 100755
--- a/new
+++ b/new
@@ -50,30 +50,6 @@ export AWK_PROG="$(type -P awk)"
 echo "Next test id is $id"
 shift
 
-read -p "Append a name to the ID? Test name will be $id-\$name. y,[n]: " -r
-if [[ $REPLY = [Yy] ]]; then
-	# get the new name from user
-	name=""
-	while [ "$name" = "" ]; do
-		read -p "Enter the name: "
-		if [ "$REPLY" = "" ]; then
-			echo "For canceling, use ctrl+c."
-		elif echo "$id-$REPLY" | grep -q "^$VALID_TEST_NAME$"; then
-			if [ -e "$tdir/$id-$REPLY" ]; then
-				echo "File '$id-$REPLY' already exists, use another one."
-				echo
-			else
-				name="$REPLY"
-			fi
-		else
-			echo "A name can contain only alphanumeric symbols and dash!"
-			echo
-		fi
-	done
-
-	id="$id-$name"
-fi
-
 echo "Creating test file '$id'"
 
 if [ -f $tdir/$id ]
-- 
2.45.2

