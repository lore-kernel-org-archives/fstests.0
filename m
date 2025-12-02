Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9BA2F691B
	for <fstests@vger.kernel.org>; Tue,  2 Dec 2025 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664861; cv=none; b=Lxotgp0coPKoRIcCVOAwjrqfd5272Qc13vCv/l9oMBB/tUlwcwuYa5qIchL5tbmJwff/1XJaGVaJGer1pCdl0M7McISg8vvMEg6A9soFUk4ykUiWBfScHsAFVZSbK9emPiCSxLcOY5mRQBCGKy9XXnl1Xuj6vVptIsw63rIE25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664861; c=relaxed/simple;
	bh=urOl0/ilTRIE2ngNhcdXcQShDJ+rl7s9PhYPUw2FR64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiggjJF+O14wilLKhclPC4etHL8GM/HBJmwAqbNgthkptRgcAjb2HLyDotSB49GJR++9GSmbJY9xJQQB17g2eBGn+UhDDbPvJfYIM4QSV6qJoX/SX478qkYa08rXPVNcOPVY3vfjm/6rJdY6++eMr5GeY5XN0GOBL32ulbgFVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jecu5cZB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbWNk3oC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jecu5cZB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbWNk3oC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764664858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ml3X7hjq+7HD8M4YETYZOG/CzOIrOxOEiDCQgxxaIVw=;
	b=Jecu5cZBk+1Sdfyc71oHK1KKTHFfNjXBDM1yPi0g2p5UpriVzXV5rDK/3GnYX/QQ/GveCu
	Sxiu1hK2C4a/ZQ2SBCSRnoJFAj78u4pR/kS92dOAtXef8hBBXjIam/XxxnSQFa+Qt8snzz
	xnc0AqcyZ1/06p2JxrYg5tB6/ztYCl0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Q4J96I0EOHOXzP8KXHQdRw-1; Tue, 02 Dec 2025 03:40:57 -0500
X-MC-Unique: Q4J96I0EOHOXzP8KXHQdRw-1
X-Mimecast-MFC-AGG-ID: Q4J96I0EOHOXzP8KXHQdRw_1764664856
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343bf6ded5cso8305979a91.0
        for <fstests@vger.kernel.org>; Tue, 02 Dec 2025 00:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764664856; x=1765269656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml3X7hjq+7HD8M4YETYZOG/CzOIrOxOEiDCQgxxaIVw=;
        b=PbWNk3oCEQLGgDlb7mxclaypl8kEzs+EwzJDXjUwCIZ7nDTCGI2TrZ5knElNyoT7UQ
         n9Rp1ypBoR/ArgqW3lcXN42OoWh7Tg3cpndES1hNg6iHxpKTJKgBI3+1iFHhkRVSgqxn
         /iG0CFc5R4gOdmm/yzc/mJgKDbBf4LLUObY9Jg/6WrPc2hq5Hm4mqUkuDS0FZ3IrDLxd
         Kc8msTxVwZCWTZYOSYk59/GHvSv4h0yS7/u2ydqIvkAc1CJS8G5F7cc88PCx/G/MdtOB
         WC3jKjpDUVZ+AlbNhu7+DHW5/Sv2QFfNwYt9cSN7dy/U20PSajZqIMbcQ02DO2a6THJh
         9awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764664856; x=1765269656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ml3X7hjq+7HD8M4YETYZOG/CzOIrOxOEiDCQgxxaIVw=;
        b=FvXn+9Glewkuh9tyJHZ0kT0AhDlnruNDfPhInSx4nAFTmct3rfk2SkQqW/0IIspwKR
         CsZKF1eDc+HbmnqRxKyrdku3RLubb7nTXgvL7CXBTP1qmDLW4SZXHrH0uCYtUBxZkpRD
         a6k89C9iYBfbD8mFEG9lwV3+8bOyDla/GD7AOWQv3jL2ytydSxu7B3vn9rKImv1FGBCB
         q7T/+N0F+ftYodGq4OKoQ+8RfNfslmBxecwEN8806Az1cG+Fl6Ucj33888YKuQWGJtW4
         lRKK0ozg5Os8hnh0aLSmTpF0ZnkkeB4GR9r5VsXwBBc4yXFHcwDm5Z38G5qgfMI2Y9vJ
         BA7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXlafKiIiLzh4zhjP9emFEt5si29mWYRMmhE+/aIsNIghFqCwQmQ2RgjkoVe08ejzHHDNBXIWE@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEotBT7PmUKBqirKuihKVVZKtq2mkqhlN7VkSxUSXtDGs2MxY
	9VxscV3GhUvfCAy6AZgAYWfWKPEccfSj+VPcw641E7kzbrlR+dfI4IQHKSGVsbZtUD8lLrHS4tF
	KDiBbZXdOigNoinkSfgahsJLLfDvwTW0T+cMIpuk6+DJQP7Vh3bI9amCmSVU=
X-Gm-Gg: ASbGncv9QhriYy8K4aisjx90NbD+wTT9Lv5ImPsftbyjseqFQwlimM8MDdrwt3H7b+k
	pjiVNpeaI+rckvsu64FwIQvFX9XQxNDkr1oIbXO9f5yVRJUj3WjcUsFX6MYqC7cp0O7fkhbjKjs
	hGrHMHEK92Zz80xwjfWaQTkGu1nSL2qtcl+HStJrgZZocT2CU7K/SwfS4cMe8YVWrmLpG0Bq40e
	GWGa+P/NqgXKx31hJ+OlksX/OUhQI5/oVatsV2l1oGO9nxIoDp8PxnaKGpDCXa6jr0Q7rBPBTxE
	OEVtJHb+jSnyMLHpxe3AV6ylyw7TKoC17WNLSTNdEB2ZswAEhV5M7WGZuNe54qVrULJuA0R4MqP
	S6tpbl4FeSBEypypwwPgsst4eN5jZcYcEK27du5mBMQhLpXra2Q==
X-Received: by 2002:a17:90b:5544:b0:340:2a59:45c6 with SMTP id 98e67ed59e1d1-34733e4ce8amr36382389a91.4.1764664855873;
        Tue, 02 Dec 2025 00:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsMo6NAYa764YoUSeOHsCNiq1tcsunmvQ9GSaPEJEpghKcA3ExolBwlnvc5cAVk92k4mJzng==
X-Received: by 2002:a17:90b:5544:b0:340:2a59:45c6 with SMTP id 98e67ed59e1d1-34733e4ce8amr36382374a91.4.1764664855368;
        Tue, 02 Dec 2025 00:40:55 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fc5a0957sm14732683a12.16.2025.12.02.00.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:40:54 -0800 (PST)
Date: Tue, 2 Dec 2025 16:40:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/158: _notrun when the file system can't be
 created
Message-ID: <20251202084050.3iovo3maspy2xo7k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251121071013.93927-1-hch@lst.de>
 <20251121071013.93927-4-hch@lst.de>
 <20251202044900.rdahcmhpf2t3gulx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20251202073609.GA18426@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202073609.GA18426@lst.de>

On Tue, Dec 02, 2025 at 08:36:09AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 02, 2025 at 12:49:00PM +0800, Zorro Lang wrote:
> > >  # Make sure we can't upgrade a filesystem to inobtcount without finobt.
> > > -_scratch_mkfs -m crc=1,inobtcount=0,finobt=0 >> $seqres.full
> > > +try_scratch_mkfs -m crc=1,inobtcount=0,finobt=0 || \
> > 
> > Hmm... is "try_scratch_mkfs" a function in your personal repo ?
> 
> This was supposed to be _try_scratch_mkfs.  But I guess that typo
> is a good way to make the test never fail :)

Hah, but there's not _try_scratch_mkfs in mainline fstests currently, there's
_try_scratch_mkfs_xfs .

> 

