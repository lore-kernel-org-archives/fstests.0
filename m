Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04844DA553
	for <fstests@vger.kernel.org>; Mon, 28 Sep 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604950; cv=none; b=Te8hPnQFGa4et47quULHlNAIJv7zTblNSimxdlc4iBpk2cWxqX+WTCPlJ3sXHSfZK7PfgqpaER0BdKNnkpzBgh5YhXmwe2JFr1nmVSETNirVAvFOg4hnkmfJrLF2ORQPzti2zQX2X7SNOtPz47/Cx0/z3dR2Hduiu+1x7ir7suQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604950; c=relaxed/simple;
	bh=SDOM9kMfdcmwCPeN+pHLr+dW12M81fI6fl8eqzTVO/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkLNaZQMkQuh5LzbdR7dsZVOfYmo97zwrWaAOhrGlAEuDAIEmslc0zqYlofGcaTVMhXIqm7Cbueq0WbT0zLBgqMo82r8r80Ks1K7GoCI9l9pSnZUlGXHCaoybRAzuv9Te4v5gAlK8ZZNpLpiT8xMmpoAqqqc5x5OxWLp/gj5gO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpZoxLEZ; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpZoxLEZ"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48881a62e09so1780287f8f.2
        for <fstests@vger.kernel.org>; Mon, 28 Sep 2026 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790604947; x=1791209747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ga/sVQ04GQ2R3OqGQaJ74GV8dl/HvsodvK0bDD2oMMU=;
        b=lpZoxLEZgijM3Dtdt6sZPsKwcvjvNUiGW3ixZ52HFcTUlVZHEHRkfW9PGcBe8O6PNr
         xMgNsy+dBSIpb4zSCe1YXR+R0Ik2+HavnyjZHW7bVoq1VjaZNTxoxttVB2UQyZU/eJDT
         PJffnrepZkZMWoSSL4itni+xwtN7bSauknMRDfm6PgcBRZo6D1CnHoi/QqwrSsVYZyNJ
         7AWOPBd675+k5XSbLMKjsCo4/iU7agUgDHFRGw8D94mZnwueSj7uDGTo6PW7RJt/vYxh
         50SstseRhV1CEdI4rUxFkUNxPJvSnZwhVFxNpOGvB6qqWK1SC/CPx4iy+e6/eFW0LO4r
         AOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790604947; x=1791209747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ga/sVQ04GQ2R3OqGQaJ74GV8dl/HvsodvK0bDD2oMMU=;
        b=RtS3F0KinMFf7AqU+OzQCa3w9rXkRwBbDaNb7seozi3jjuZMGtaHlX5ul88ImZ9//o
         7EPOGV6WFsZuXEm2y9PDXm/L1887XeDtPfdk4jcSO1ggzyxoAVPSzx513MtjZDjrOlHF
         ap/Hcu94RZMGp91nY57aG8LYtF00vhzftNZErYcaIQKCQTIkHEPHjBgus33yqI13Dqd+
         EqJ3M3h+4n0N3fSA4aBqQrt6X0ECr1UULjTaOCL0Ru+V9Pdkd/yrTICTu9edk+ndl39b
         uNpvWbSkGVzoIr+L7HngWfY5qv/6p491RA8tWEglRjeE5SlfMhpqSyXyHMwrKetyL1nJ
         sM+Q==
X-Gm-Message-State: AFq9FYIwbX9fLqcOpkxrTyYu0N8s+WNkZlH3VuihyDV9UlgP4NTcJ/wl
	lBcscVXzvGAnb35yL8hY+oAiLLOALTHep/JImZZbv2a3sYfPUnn9PTiM
X-Gm-Gg: AYBFou00HP746CuMpCbkNSmAHng5lVkI0gdmTEAo6PbZGOpusy8b8ngSTI4Zh8iF3Ok
	Z9SDKUGSKTJ1HP6B6tJ8yrrW4f4fo9X9pf2o6CJnlxXYU6bSOlKPDVJpw1Y1DSFhPUSonwqHJ/N
	lh17vYMCsTyExvV5qOcATdfHmOSLasrft88PNuRvjOStX7B5N0wf7tp+i01fwGqclptA82Q2Eqs
	yt/vfbofF3KlXYJqUl+4Tt11phmJG9WDk7DeJKQyUlC957NLtASbah3j20o6qejeH1hlN4T+17Z
	pUVfttcziOvMIrtl+s2Wnrmy3aa7Ky+pyukxSQhWury/P7P10X0yTmn1dh5wyNgLg4jilCwi6Vp
	xrKIuHA/dMYu+Na9SxWKCzHVip45/WZang30aEkoJS0yQgVTuOmdwoO9kTF+JooSp+Nt0MJzPrA
	QvoqQbGz8z7ReR/5IaDKoM3Y8/C2lfL52SydCsXKlMvB+gkaUyQ7laO2e9iSwhmAkZ1x0XaOU8i
	QKIg35uloUcOMbV8gFvGvBP7UJiqg7zJcqUgToStY9Z9WcMCs/Y6KV20ClYRhpqSkgx1p7noVzn
	4tnd
X-Received: by 2002:a05:6000:2504:b0:487:1256:ab80 with SMTP id ffacd0b85a97d-48871878daemr24468120f8f.57.1790604946641;
        Mon, 28 Sep 2026 07:15:46 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6470b7sm28317186f8f.27.2026.09.28.07.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:15:44 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] xfs: exercise a failed CoW conversion during writeback
Date: Mon, 28 Sep 2026 16:15:35 +0200
Message-ID: <20260928141541.305360-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arprh9oyZEXs25CQ@zlang-mailbox>
References: <20260928085047.7250-1-parri.andrea@gmail.com> <arprh9oyZEXs25CQ@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026 at 09:53:29PM +0800, Zorro Lang wrote:
> > +seq=0
> 
> In fstests, $seq is a core global variable representing the test sequence
> number. Overwriting it here might lead to unexpected side effects with
> framework helpers or cleanup logic. Could we rename this loop variable to
> something else to avoid trouble? If you need, I can help that when I merge
> it.

Good catch, thanks.  Yes, please fold it in when you merge, if that's
fine with you; the rename I had in mind is just:

@@ -48,11 +48,11 @@ _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
 
 # Dirty several widely separated ranges of file2's CoW extents so that a
 # single writepages() call has to submit more than one ioend.
-seq=0
-while [ $seq -lt $nr ]; do
-	off=$((seq * blksz * 2))
+i=0
+while [ $i -lt $nr ]; do
+	off=$((i * blksz * 2))
 	_pwrite_byte 0x59 $off $blksz $SCRATCH_MNT/file2 >> $seqres.full
-	seq=$((seq + 1))
+	i=$((i + 1))
 done
 
 echo "Inject wb_cow_convert_error"

I'm happy to send a v3 instead if you'd prefer.

Thanks!
  Andrea
