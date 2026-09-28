Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959064BD36E
	for <fstests@vger.kernel.org>; Mon, 28 Sep 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612690; cv=none; b=GtCLFHKbNKCzhUlPanQQJ+I2bCdazPnUZJykJsUb8BvOkwq/YGDE8QxfD0ji1KihVI+SAa3a3XdMx/QwpmiCBFKDO0k/UQaRyoQ33488mdastWyqzIgqu02/tsWIgDmo0HB5aMUFFPOMpdin6wvbChc0NQOzJbMtdzxHW5K9xFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612690; c=relaxed/simple;
	bh=VC1AlWwK6+xkcHdk+oDX/+XlZBn2WYwLvo+m0RuQYiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsVhDszVI2ebxX6AeYwgCWCcy0CTAtgBZMVYVMIC8sB7zyLKSa59oeZFWV3VVKJdMP5PM0HfpwRXd7pKES+AfNsYTYNfMuJKTwM1sZv6a/PdvsvnDTXwwzkeoMAP8KvJGu081zz1OPUp4rh7kAv8jUlndkis3QBrPpSjjH+PNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEqoMN0n; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEqoMN0n"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso24100975e9.2
        for <fstests@vger.kernel.org>; Mon, 28 Sep 2026 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612687; x=1791217487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpsKAZQhsZqa/8JtSmQCc3cc5x+c13Dua7F09qfzihw=;
        b=rEqoMN0nPcIWwIhcCxs5PMQdff5qX4Lp1k/DhHRVAGyIRfBeCCHfq8BV/7P+8nFWg6
         xA7FC3uQ1zeD8Y3ABhHQR62Kd5cSwW1kDLR5GFjZN39RB1gvYh718Fn17TDSPA1DXhUX
         odwjK2RdBgBQuZHyj13ElSy8034zBbb8yRehWtLQPxN/LiSq86kUTJ0EJ3hHNX9HrsH5
         kFETzxyd2M6k0G0hjmkVZE54slEz9O/W37YRVPAlfdKWgcoxjG/R4bmuGwfdhX/VAO9V
         ws6NDfGUWILg24kf4p1GJWwFU89WgRzO+h8ImVym4HVK4uKFSdjlrIseu1M+5wZM8kIb
         wmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612687; x=1791217487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZpsKAZQhsZqa/8JtSmQCc3cc5x+c13Dua7F09qfzihw=;
        b=BDAPpuK0Nwf42QG8QDLbJiGrR/H0H5iQH7yyGfxCnrqsBxBqhiNTS+JhUvsCI8ZcGG
         C/5qxs514QbMJlr9LWL2sXRvwqKC6TeBtWQsdJylt6gH4hVTdPgzOAykl8w81IYqpXg3
         8QKTctYDYzii9+Y73cy88patxoAAzSIqKR9+NAimDb9/N0Aow6NmeqDzOOGJAONIgkyD
         jREcDOXtnEJ/IllM3np3+0z3RTHPbb8ghRBf1JDBnhC+Bf+QV/+bQPsF2SCQM4IjAekl
         2raKI04+MlgtC1RUO+3Cy7ekdWsLUHO3sbnTP1bzhXofvSyWRPPzIQ38aVZko9m8+4xy
         9G4g==
X-Forwarded-Encrypted: i=1; AKwUvBzT8qMQen+AbGY5SIf4pSvXE6vzG3b9Y6trxHAqBdTjz/VLMDSYErr5qv7gvgbVU6RV4X8q6nps@vger.kernel.org
X-Gm-Message-State: AFuF++nytX807ifMMXgu4jP4GjM3KCts94VztYnWHTBrzuiYZM5G7ZFt
	HBpDXRuAP6nqY2BIC4whbNXnnLcXnHYf9gUevZ5eqHIVQVeblmQcov1+
X-Gm-Gg: AYBFou35Thv9tZR+jIvQGzfhPzWYttpo3X3AcnDzWCOldpEruW3+Hmz9DIhRHZgvvEJ
	Yzat8g5fXvbu4Yl5/jF1AIJfNtIwgOlQByi8bh4lAA+nSGynvUMucPtiTcd5bReSc0tkOtXA58B
	CD83Z66X8i8X2GGrk/HqCHvebdYyQn+DEzoMVdhMLc29ShqBfJvawYsRzX8GHvh47xQ3/K/IL5k
	Z4wpbBnBTsNjuC+PjP0EIczXJnhxPXk4AfBmWxHxvYjGcDxKexfTCiPx44ea/iZxfSlEvwGLPoG
	AM5LjQCDtHMV40U+qTL+mOnf07qeW+eix+eN+lLH2hVJvOlU9Rwc+tzffxhyA93fXY2syNlEMZ3
	a0UCS4iXnYV91Har6NwrltgPGgccZBlzhky4kyfugjZJEGbNW5MAnNiktnrbUIQLGQTR47wmfuj
	I1t/At5ri11FUtZm2RTzM4XrYXvKJRxT+XUmPnqW40rRTKHgU9kW6n6zpRFv1roJ4zHJG/5867k
	K0aszO3SGyU7RjuN6JvTI1PM/oUmohrraJoZmVB2bDb1aZvF6ww2JYSyhG6DQp7MTyy/5AW/3ed
	jMHg
X-Received: by 2002:a05:600c:a06:b0:49f:fd4c:cccd with SMTP id 5b1f17b1804b1-49ffd4ccdd5mr112458605e9.28.1790612686557;
        Mon, 28 Sep 2026 09:24:46 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf2d973sm5148155e9.0.2026.09.28.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:24:46 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] xfs: exercise a failed CoW conversion during writeback
Date: Mon, 28 Sep 2026 18:24:42 +0200
Message-ID: <20260928162443.352542-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928154149.GA6253@frogsfrogsfrogs>
References: <20260928085047.7250-1-parri.andrea@gmail.com> <arprh9oyZEXs25CQ@zlang-mailbox> <20260928154149.GA6253@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026 at 08:41:49AM -0700, Darrick J. Wong wrote:
> for ((off = 0; off < (blksz * nr * 2); off += (blksz * 2))); do
> 	_pwrite_byte 0x59 $off $blksz $SCRATCH_MNT/file2 >> $seqres.full
> done

That's nicer, no loop counter at all, and it writes the same eight
ranges as before.

Zorro, if you're folding the fix in at merge time, please use Darrick's
version rather than the rename I suggested earlier, i.e.:

@@ -48,11 +48,8 @@ _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
 
 # Dirty several widely separated ranges of file2's CoW extents so that a
 # single writepages() call has to submit more than one ioend.
-seq=0
-while [ $seq -lt $nr ]; do
-	off=$((seq * blksz * 2))
+for ((off = 0; off < (blksz * nr * 2); off += (blksz * 2))); do
 	_pwrite_byte 0x59 $off $blksz $SCRATCH_MNT/file2 >> $seqres.full
-	seq=$((seq + 1))
 done
 
 echo "Inject wb_cow_convert_error"

Again, happy to send a v3 with this if that's easier.

Thanks!
  Andrea
