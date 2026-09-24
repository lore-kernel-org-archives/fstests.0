Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC354CEE71
	for <fstests@vger.kernel.org>; Thu, 24 Sep 2026 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281854; cv=none; b=JMFzyXvf5FLsTYZwZR6cgXDSpzkbB/82psm4kCKEvNEw+KbrFt1dFR6T0pnrJA9QVz/LMvC3eh6XRpip40MhPuFOW0VqSU1EvhXghBTcsZNQlU7bAZRXpVWpTYxvq/4mbEpTWekFrV0hf8sv0kO6WAQrH5ygpfDFK6UF4KKVee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281854; c=relaxed/simple;
	bh=sNCLes+Nr8GdiPL1NRKJ67LtvVV78+FJjPyBdyB2wRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh2NY4bJFyfW9THP1g9tH0NmDlS7V4oy8a169cNVw9ja/pte4INQCHB2A+tNDXVrS3cReALjG7FBLCCpEGPY1HMdMAnlBzLaVZFQvZRtYRrue9dd2qWlph14/OoMMKy9gnlj6yA96svUOqfOFVnw/BvQ4XpR1l4f6TnKFtcDPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFQFiSN4; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFQFiSN4"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so1281615e9.2
        for <fstests@vger.kernel.org>; Thu, 24 Sep 2026 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790281848; x=1790886648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fugK9KDhlq8AsbhsMEMofQRn39cWbmYkPHkf6oOk/Vw=;
        b=AFQFiSN4LvWI3pXnzyPspPlunwCiqhh23yojo0NW77B6hhwkE3bpceTSO9OE0S1P0D
         MNZVn1JvwUZaXrRUN0G0D2ydY/0/h4RJRRAWPB9RUgMxviY119JqiYWuUUoBhCI6rwat
         qE4yHuEGAeJRhVylPUdQJV86ym0nsItbQ251YiVhaCjekyI8HB5CNlqjXLMorb5gYU+h
         akIm5fvnuUudJwY2s8GafRkcM/Udn2gAnRZxVmjGKsGnHdkyU8NjPTAUqrgll2hwtiYQ
         SsKLuqstnCyIMWy2LMal6nr8Eer3yYo9z+Y2LBcKnTqlw05tcKZdYGeJpzJ+itcuZyXT
         CDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281848; x=1790886648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fugK9KDhlq8AsbhsMEMofQRn39cWbmYkPHkf6oOk/Vw=;
        b=TVh65ZYJRZbEuqtxzeIzuPbxAUdpcFGhnZnzvfeivfzzUI26213WJrYW3ga192v2Nz
         bOtvFeeVzGls3P6q9CZX7tQJWuoXCZ+SDJcc7LA1AAuOAlScMdg7n6RnPqnMa6A8KeFH
         cPLuJyM9oVArO/hZlXDOIQBQHV7YdV3iJXW7NRY6AIM1olnn6RY2VdhZ2kwO36RUMgqm
         heNU3ENveu7lyO2po9J0IhsHCaZbR6UjXr6cOo3FGOQfngpecHt25OENmTw4bvr1QSya
         kw8dh5uoJeexTJFl8ORh2W17UQ9BgZx4pOihSfu8jALc6aaCzOG8i7kquelEhEClFSSd
         h6CA==
X-Gm-Message-State: AFuF++m+gOwK7PUaoeSFJ3W5UE9gm2chV6PswUZ6IH26tE2qINIeNu8n
	IKbvrWQ/9YwtPOCZIPSSnMTaXD3IBUdIxJ12J+/cut/UBFrw2lj2WBx6
X-Gm-Gg: AYBFou1vqkHq48cr9vTxEqnmaYW+9Dl7VtJP5QM3BIh1cWG3Q3mMoszLryHSKqtbnsP
	7Jk2LcOTDU/uuY7E8M6f25GGjVp3W0kfh6p35i9KF/jsszyN6uA1DJJqFqKZ0MiOmzEmf4QnbPI
	IkE4xe+wC54POj4zOvVfnpPQ1+n140MXTRuOUpF1w3uA3mX9lyr9WGRS/o/LhQDDvICodB5C1Y0
	Brqw8xZugnGVQblfCmdnFo8bSBLEud5rMmGROiOV2BgxLcIft3SS8UXhf/5jNlkha1ag6d4fgB+
	jNHPCja07vSGDCHN9v5Rg+FzCUDJDUbrXLLqkqejwdwnFiWySiuG1j6pbzPyLY8opdxc5unY6DJ
	FnJXThbJOLWsMY0Tq9gHuDu4QlkOHmKzMJ5rVfzzPJuU8a+jPIq36Kqb/hFPVb0LksxDChrKiaC
	MiqqkjMBAP++wY91Q4K3taC2ONUWhIYRPE2xHVWabrhJtiwl+nl0EHcTFuLyWA808qGD8FW/EWb
	QHVnSEMuPPafsbGVgTKbtzB3SR1FsIzhkJLKUPwgeE9GcY7cn1D4GQ=
X-Received: by 2002:a05:600c:1c25:b0:49f:ce78:3561 with SMTP id 5b1f17b1804b1-49fe66f19demr69766585e9.18.1790281847407;
        Thu, 24 Sep 2026 13:30:47 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30c43asm1720776f8f.3.2026.09.24.13.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:30:47 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org,
	Zorro Lang <zlang@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: exercise a failed CoW conversion during writeback
Date: Thu, 24 Sep 2026 22:30:09 +0200
Message-ID: <20260924203013.9967-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924185449.GL2705364@frogsfrogsfrogs>
References: <20260924091338.198407-1-parri.andrea@gmail.com> <20260924185449.GL2705364@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 24, 2026 at 11:54:49AM -0700, Darrick J. Wong wrote:
> If this is a regression testcase, it should cite a kernel fix commit,
> right?

Right.  The fix isn't merged yet, so v2 adds

  _fixed_by_kernel_commit XXXXXXXXXXXX \
	"iomap: don't resubmit an ioend after ->writeback_submit() failed"

and I'll send a follow-up with the real SHA once it lands.

> > +_scratch_inject_error "wb_cow_convert_error" 0
> 
> It's not necessary to reset the error handlers if you're just going to
> unmount after.

Dropped in v2.

Thanks!
  Andrea
