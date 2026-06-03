Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1D41754
	for <fstests@vger.kernel.org>; Wed,  3 Jun 2026 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780458466; cv=none; b=AweyQLv4XtfbHHdUjeWjRpNR3CKNvH80FM1Jj+BqYdRV12QZkjxNjR407uyvtDnWqj60HgxbmEhVcYwpcnxJiyfRpa/WCiOc2//0QS5dUlPDDX9EmHGb3jTBPJB0lX35nbzPgN/PlHOsGg+IJtWpoeF3yOyxD8axLEN9SRvXBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780458466; c=relaxed/simple;
	bh=Nje3WKC8yyQvq4+JF/3NNF4jxb8K/8yZs3LESlJwse0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FNNCVAn4h1qhknGfn0cBfBu4/StLpfqqnzdOMtx/RXR/sYp5LhT5KnDdn5e5PNCBISkI7KBO6LARNjHCBScYw8DTfMuYsqBvNbp1E6qgdd89uFx7bKsmV0OVRPSHESLrUtFlO43T4GhTRaddZLE8GmTxF+ENf2+MA9a1QcCQH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHxh4/bP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kPOxlI/o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHxh4/bP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kPOxlI/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780458464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jELAzydTpLqJauLMjxG3Nf/vl6j8HfTPoO2hXMPU8fo=;
	b=cHxh4/bPfRlxNiyuDESr6HWoAcC/SNV+deDtlEhXcXkStEKSWDKLsx2px2aQCLQHPCniVu
	dhrfTQl/OyHyaGBdS+yhFG47w0BQhbYdlcDgWBxKcuy70ZJKoL+a0QjBPaxYK9gDdR3b6C
	6a/1PQi9G+WQgYYaBw2CIZrCALmu2U0=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-yFV0Bsf6N_a6BdENjvvnWw-1; Tue, 02 Jun 2026 23:47:42 -0400
X-MC-Unique: yFV0Bsf6N_a6BdENjvvnWw-1
X-Mimecast-MFC-AGG-ID: yFV0Bsf6N_a6BdENjvvnWw_1780458462
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-43d197b99b8so4481209fac.0
        for <fstests@vger.kernel.org>; Tue, 02 Jun 2026 20:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780458462; x=1781063262; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jELAzydTpLqJauLMjxG3Nf/vl6j8HfTPoO2hXMPU8fo=;
        b=kPOxlI/oEAJAnXKfDuxBBg730j6FxAxELaUl8G1lP9UqFHRjllG2z7sjXSbGr0qYPO
         l6kTyzrNAZo2+xDq/GVFBjFYGtvqB264qCOAMfu9kzoR8mJ7qX7jUm3qtaU8RdsBYaVi
         DXWtFPwXFL7qjuxzRT1+QuE3QT+6sI06VHQBs+fQbu5cnDU3/kFywsZSqRDnHABteWj8
         9pCFlke7Wv6Z5dkTQoLT+wHAZKGrKiWG+d5ZU+qIFiw/zRsYoe+QrkkKx0NvqIUzP0Wr
         dw++aeRLcHbUhYNwCz0FoDJBCCPQxGaIaSOKXtLugTUz6tw5DjXjk/f4bJjtS4XumWDr
         xspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780458462; x=1781063262;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jELAzydTpLqJauLMjxG3Nf/vl6j8HfTPoO2hXMPU8fo=;
        b=m/g7ZK2NaoHryzZudh2H4NNhFCHUktYGHe2r2182s9/EeBaaXAKGtgxzl4vWZSPATR
         AgcHTgIrlVp73dl5KMx+rm4q4axxJQBzrGx76gygppLAAWmp81z7GIY7T06Y486S6K65
         P1QPTnl2r3xjko4HALCPaABv/RgsUecp5h0X4ioSaMx1xdGaP1nUP/fywfQeK7zSPARG
         +nNf7BW7esv0xYEDps7MxuBcGMVfbGgjhOZo29hgU9M7rY+xUJPOCo2T3cS7UxbpghjS
         nV5Bbfzd9R2hhGg5Yqg5Zb//lp9LgjpPbeLTxKp1mZmyAmpg4jNtESsTYqE/4wdknnMs
         n8hQ==
X-Gm-Message-State: AOJu0YzCweuljQzLumZ0cJ1E/qkiGKlhEolji3T2pighCkRvhlfL+zA9
	YervNGq/dUxhd9KDXuoLtxn/6ukuTH6DRKR/d+Z/zK0PoIxJmWk6NC++00oSsbDlAio7M9O4weZ
	7/uFa+iQxnoqGawMM1Qy+y/GZRahXXn40Ul34xP7p5PO2EHlkgHtqx1LAz2IwZgwDPEPYXz8uhs
	PsCX4Vc8rxltiq62EHc3+1AF2H81JurlJe2D+4Zp0e9w==
X-Gm-Gg: Acq92OFb+TvGbjppVz+saqUhDj8+4zsxTFmTBaWFJ19ewC+aS9GsW3t6sopMmADdM7g
	MFKbvlC+OKYJJIWkQxB456AJ2sAODkOwd6OJPsLnuzTDlpLRFecOLmC+BPNx29LXnyrnykvrH7c
	plY0Sd4UH08s1LSn0IliizM3W2Cyw+4+2NO2VJ3HRGRiInjV4APi6eU38lv1yIGIJOpRlwASy8O
	Js2OY8MJXhHmv6XWH43kIR6mjpwoaa/lYcNscv9rXUNjUrMk14oA68vjgcA/h7NziqJur1sQWHj
	WvCdahJ99cjN13om85CVlGUi4NtrNoKEhrYOlMbVOQTUBvAiGJrot8Z0fFenqDUJ07jHz82BWF4
	xxQTOlA1z/I84D27bB2jRY+RNOI4kDlkhLfBF2pM1UfcRsw==
X-Received: by 2002:a05:6870:c14f:b0:42c:127b:a973 with SMTP id 586e51a60fabf-440db593cc4mr1395392fac.7.1780458461703;
        Tue, 02 Jun 2026 20:47:41 -0700 (PDT)
X-Received: by 2002:a05:6870:c14f:b0:42c:127b:a973 with SMTP id 586e51a60fabf-440db593cc4mr1395377fac.7.1780458461132;
        Tue, 02 Jun 2026 20:47:41 -0700 (PDT)
Received: from [10.0.0.119] ([65.128.98.105])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8297395sm1408693fac.11.2026.06.02.20.47.40
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 20:47:40 -0700 (PDT)
Message-ID: <a31e9841-fd0c-435f-b376-86a7e01ddca7@redhat.com>
Date: Tue, 2 Jun 2026 22:47:39 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] btrfs: use -f by default for mkfs as xfs/extN do
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Recently saw a case where testing ext4, xfs, then btrfs failed all
btrfs tests because mkfs.btrfs refused to overwrite the left-over
xfs filesystem on $SCRATCH_DEV.

This seems well-enough fixed by only making the change to _scratch_mkfs,
but several other helper functions explicitly use -f / -F for xfs
and extN, so I've updated them for btrfs as well.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

TBH I'm a little baffled, has nobody really run into this before, or
am I missing something?

 common/rc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index 9632b211..e77edf97 100644
--- a/common/rc
+++ b/common/rc
@@ -871,7 +871,7 @@ _test_mkfs()
         $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
     btrfs)
-        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
+        $MKFS_BTRFS_PROG -f $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
@@ -920,7 +920,7 @@ _try_mkfs_dev()
         $MKFS_UDF_PROG $MKFS_OPTIONS $*
 	;;
     btrfs)
-        $MKFS_BTRFS_PROG $MKFS_OPTIONS $*
+        $MKFS_BTRFS_PROG -f $MKFS_OPTIONS $*
 	;;
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
@@ -1010,7 +1010,7 @@ _scratch_mkfs()
 		mkfs_filter="cat"
 		;;
 	btrfs)
-		mkfs_cmd="$MKFS_BTRFS_PROG"
+		mkfs_cmd="$MKFS_BTRFS_PROG -f"
 		mkfs_filter="cat"
 		;;
 	ext3)
@@ -1176,7 +1176,7 @@ _scratch_pool_mkfs()
 {
     case $FSTYP in
     btrfs)
-        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
+        $MKFS_BTRFS_PROG -f $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
         ;;
     *)
         echo "_scratch_pool_mkfs is not implemented for $FSTYP" 1>&2
@@ -1369,7 +1369,7 @@ _try_scratch_mkfs_sized()
 		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
 		(( fssize < $((256 * 1024 * 1024)) )) &&
 			! _scratch_btrfs_is_zoned && mixed_opt='--mixed'
-		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize "$@" $SCRATCH_DEV
+		$MKFS_BTRFS_PROG -f $MKFS_OPTIONS $mixed_opt -b $fssize "$@" $SCRATCH_DEV
 		;;
 	jfs)
 		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS "$@" $SCRATCH_DEV $blocks
-- 
2.54.0

