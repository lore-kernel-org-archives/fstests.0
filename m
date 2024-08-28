Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2591898F6
	for <fstests@vger.kernel.org>; Wed, 28 Aug 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856684; cv=none; b=IByBRuyzdc5lG+f28c11O6jujVeMX6aKJcHbqS+woxtYPo5r1UD7Au/IARLQj5FWLOEO7hRdu6/fG/jimwLhIw/cpyP7THptHg1ugJrn+9ru8vojCEYrRdef2wKY/BBryZ7XhK2cuL7ClUvyBT++JCIWYD3UUKkxGmaOAo0RWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856684; c=relaxed/simple;
	bh=rbYF9EQE6+2l/S8qLuOSkRSe2U+4urx63JdRyvn3Tq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q34njC8vCsPKjUzjVtVoMShZFsSjh8FlTLFg5C4xW73QGzdEPFJMbsvH/whgBHGA1UQ/nVdkrYkAwyEM7/WRVhbdwN7UeX2VOH1UHD81+TASrS0PC1qPj3HQZrSVg5578RM/TTUX9i1zWkfoPt/ixeiaBCnvo2ToQ6RX/3J/sSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sOcWWwTu; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sOcWWwTu"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82784c8bca5so216238739f.0
        for <fstests@vger.kernel.org>; Wed, 28 Aug 2024 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724856682; x=1725461482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkBMJ6J7tx70rz6zmOA31ER4Q+skEgbVfFZ8HyWSogA=;
        b=sOcWWwTu66gx9nBISRms8YlVMHBwqLYqwrIRtkz0p/fFg5TIgNSLV/E6qlazZZvkFJ
         3g9UrAaQKqqghTbx/pTGcy+TGSCgBTXDgnxSXTvr69SgDljLZk2nvDdDhsar5BAl62xO
         OsPvhhMxmf5NFnK2nhMXKaPAy8QIvOXalqGaL74PmW/fctcQIZ8b2AgHzVWlZz1CrSG8
         I+msLL8ImwLNcgbNn2QcQQFZe/CNjPp3qL83xPpIIyOrP4xJvM2sq99Bk16+ppxbg1Us
         /S3hW7LKOylLzrwEOdGO0YpT+RIL1UmJqDiyTHTqIQAtkvypv1a5mNJsrePCtwH2Tujr
         9GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856682; x=1725461482;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkBMJ6J7tx70rz6zmOA31ER4Q+skEgbVfFZ8HyWSogA=;
        b=t2iJbjz8YknpO5MVOp7VLrSr+ompncFV9oraypxzc5h/APmrCd3mJKQ4NRbI6h1mZT
         uvoA84lo2eItnivxNeBIavnLrO9y5cP1+9qd/9RbDaFfGJxBW99K900NsrdAmIWYUC4r
         rjvQ2BM/klWVmApHkzj6bU9UKjixvpKVYGWccCAa7p4lDbd7NhrJotpZsWUnaKkWhWN0
         NpjklpK3JYMh69g8W1zCu5mgGWQvuc/lPykk917junrGjvJ/QThiSvWR+DrPiTl6xChJ
         xJbyT77bA4ClYNAzB/1y76z31EBzq7TmmazfoGF1HSnSpivWAYXO6Tdb6MhYRzl+ev+4
         URzw==
X-Forwarded-Encrypted: i=1; AJvYcCXejQvopODNiMMC7UalJDZMO38TtX3NyCijVQVL+RXg9PSm57HEWUCdZVe3EmvfaJDljWuQgSc6@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMELVDvTquVcXAvS0LvhDleehaU/+7YchxaN9iqEGvnyCIaQA
	nH6k5lnd7vtPdpLrnB9xRV15Y8aHOUgH9FvXAC7iO65XXsLm/6kgVDUOIrD3MXOPYuP6dE5SsrK
	c
X-Google-Smtp-Source: AGHT+IGH/sM51D0GQjar03mWbJeEot9AqwANMQY365pltcRA1L8eRTcfI+pPccqJjQxvsPbCCa2OWg==
X-Received: by 2002:a05:6602:341a:b0:7eb:7f2e:5b3a with SMTP id ca18e2360f4ac-827873116d3mr2276078039f.2.1724856682153;
        Wed, 28 Aug 2024 07:51:22 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f84e20sm3092887173.84.2024.08.28.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:51:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, 
 linux-block <linux-block@vger.kernel.org>, linux-scsi@vger.kernel.org, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 fstests <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>, 
 John Garry <john.g.garry@oracle.com>
In-Reply-To: <20240827175340.GB1977952@frogsfrogsfrogs>
References: <20240827175340.GB1977952@frogsfrogsfrogs>
Subject: Re: [PATCH] block: fix detection of unsupported WRITE SAME in
 blkdev_issue_write_zeroes
Message-Id: <172485668128.410120.18023172929961192707.b4-ty@kernel.dk>
Date: Wed, 28 Aug 2024 08:51:21 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 27 Aug 2024 10:53:40 -0700, Darrick J. Wong wrote:
> On error, blkdev_issue_write_zeroes used to recheck the block device's
> WRITE SAME queue limits after submitting WRITE SAME bios.  As stated in
> the comment, the purpose of this was to collapse all IO errors to
> EOPNOTSUPP if the effect of issuing bios was that WRITE SAME got turned
> off in the queue limits.  Therefore, it does not make sense to reuse the
> zeroes limit that was read earlier in the function because we only care
> about the queue limit *now*, not what it was at the start of the
> function.
> 
> [...]

Applied, thanks!

[1/1] block: fix detection of unsupported WRITE SAME in blkdev_issue_write_zeroes
      (no commit info)

Best regards,
-- 
Jens Axboe



