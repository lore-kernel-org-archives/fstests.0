Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C723BCEE
	for <fstests@vger.kernel.org>; Mon,  6 Oct 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772296; cv=none; b=eR89Qd5QcUWNzBK4abWXTabe2Zci7E0B9qrufEUxMERU/43lT3RvW8WwHafOgryW+lYnArmzB291sSl5rI1/T6qET3Z8HB3sAefEwled6webVy7sB3CthHB2AD9X2JV8d82wtjBbl/9hBfX/rmkaB2tMmJD881N/ZSVfny3exUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772296; c=relaxed/simple;
	bh=QnFXC5zW6cJCdtb/gGaLtSphm2wouXQIppnYFbVFrK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzrW93XuIcjyvEeax+tiCMz/+0cYbU3EBer87X/WednbELILOlKiQ6QjG2kmiunaBR8vXxE0EKcuuVHzy23zPFsxtAj9pF63spCPxznIO/m5GpYPf0ZMlzdrC503DSvtTZDCt11PE+vxvNVoiYWp16JAcTTVMbE8Q1DfwU5FXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSFjNWMq; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSFjNWMq"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-72ce9790aceso53990257b3.3
        for <fstests@vger.kernel.org>; Mon, 06 Oct 2025 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772292; x=1760377092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ebqmr5rKLRyhSXCzWYO8AedjCpJ3xXFZUe7FSLwQDLU=;
        b=YSFjNWMq/7GFMPkLfem70lo0gIlUkS6p0DCnmLSK1pbto2slAJUb1mG6t5tnJhaHz9
         TBzqR0OdD7DwtKVOVMUijGj7rJFsbIEQQUhcBc3GoW4Fjnqmp+0h3HFLa4RFNspoyNqr
         pFYeLKdKdgh6x668Feq2/Ubx4TCaS8nVu806754huir237rj1TcySfzR0oBycnQJBk1X
         b/qCia9u1lZ60kAXSV/W3utFl6g8BzrfKmGFCUlugy7N3xy+sYwq/NMtpUo2E6Hn9+gt
         3pcRQ1mt7304PaBd8VNGtSQ2gG53EdLbSxEEhpT19V0dlUCZGWk1VGTOloBRslId7nG4
         gzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772292; x=1760377092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ebqmr5rKLRyhSXCzWYO8AedjCpJ3xXFZUe7FSLwQDLU=;
        b=NeTkQJz+xS5IrKz9Jpoqj2vi7623ZN47DQF67c5D8TM95wzuSYdoggcH7HrCQFJy/e
         4GffBY4IJG3vBt8ei9T6FnEdOKe02sRySpY/RZMHy7RQyG/kHr2XfeItQvrLH4jT0PNG
         Oq1QBIQLxXcwppHav49RFHMWkD022cgpFZwfADM2eOGrPPKuy/T6nXfRF43NHTKwk4my
         gNqlNY9ansC9cPYjcFnPo8EUUyOHtjMUt1FLaPaYOag8v1v2zjN6z2ENDyYI4aJ66WTo
         oIhY5GiftvJghQRhW9vaqoQfP/mzcXet7fkyO3iGszuEh9839FxPPgXehVdcOViR9W9X
         q1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxiF66TS9qL5sPVKDPDTXoICaVPsR4nGUg1em51pFjn0uay4wJlXIRhYgPszVGy83jMyY77juE@vger.kernel.org
X-Gm-Message-State: AOJu0YzltlIgZZiFlbkbxud1NjJ2SKNpls2CBTJ7Af1AJt3XBGb3cTqz
	7BeoonmfOXA7Wb64bHs6uYN3NgWnjSpMUwIYehdHVvwPNrrnlHGWI/jcmC+8UlZ1
X-Gm-Gg: ASbGncuu2jyhzZ5JqnE1/yuh4HORnOSOUpznKXeJXveNFGUA2DT2vwn4dcaw1Qs8s+w
	hHwQrgWuIFdYBjuBmS1WL6ESmh4jbIFFUW5AaDIXA1avdzk2wqkv5WCSMbc0Mh39J1ehek9vcpc
	LtgKnbcaaVv+7mzmfDlmSJuUF/y9RCjnAHbjwbw/bjyfbydBRtXixyIftPXZ9MO4ZPQ9qfKjgjc
	JlS64se8tiIpfSsZpzrhCWdjyX9lHLXF8chddQcaAQQR8uwBn74Ys64C1yuHOwpvlOshWCCMTlE
	w+nz4PkZoo+vCW1uZHEAsa6ODWI0k2tmSzbUKRJXGKOF+8H9vJRM0o/LH+emQxtBm73dIY0B/0Q
	9NqxtPo2RK6XpVkqaldhNPLyn9TYp/FS2v2mssqQrwrjAs7jE/FqcBkgWSeijXE4=
X-Google-Smtp-Source: AGHT+IGy3sJJ1NWx+Evgv6lnBzDFvoHdGCSaAHyLtLpyhpqlmQ4Ie6WjNK9or+TiujwoFWeIiKEgrg==
X-Received: by 2002:a05:690c:f0f:b0:773:a86d:7662 with SMTP id 00721157ae682-77f946d9d87mr248418497b3.26.1759772292229;
        Mon, 06 Oct 2025 10:38:12 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81c06465sm45199607b3.6.2025.10.06.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:38:11 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fstests: btrfs: test RAID conversions under stress
Date: Mon,  6 Oct 2025 10:37:51 -0700
Message-ID: <20251006173757.296087-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <55d549d2-fec1-442f-ad9f-875d2ec6c864@suse.com>
References: 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 4 Oct 2025 11:24:27 +0930 Qu Wenruo <wqu@suse.com> wrote:

> 
> 
> 在 2025/10/4 09:11, Leo Martins 写道:
> > Add test to test btrfs conversion while being stressed. This is
> > important since btrfs no longer allows allocating from different RAID
> > block_groups during conversions meaning there may be added enospc
> > pressure.
> > 
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> 
> Please do not mix patches for different projects into the same patchset.
> 
> A lot of us are using b4 to merge (kernel/progs) patches, which will 
> merge the whole series, including the one intended to fstests.
> 
> Thanks,
> Qu

Got it, sorry about that. Should I resend the patches?
