Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B761279DCC
	for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776358040; cv=none; b=gELn+Einv+SY8cKInbppiM2WkgwKFMiJy+LIUUsnBC98tSgZ+5fr3ndoaZywZZIGsqf993S5QRINhLu5QbgSyR2mDL1skjfnfglp/yVBmEZhTJhIpnDUdohrQUg9iZaG9uLzlRn5DyckhS/33HGMl67nQI6bGrwQsbKKtoPKwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776358040; c=relaxed/simple;
	bh=5mk9gLn5It7DPxJigFuEO96ijIahfChkNv4cAvOkUys=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4y0kgzszlvmgSQAkbN4KpmRsbdDVHHNeioJ3Se+nqMOTFTYyxJR3TgsFUE23KC9yQKhr0hMjQFm/lGX68/uoJ07a+vawa4QxPBmdxcbFSTDY7PfP4eAb2CnQjQ1JLR2BaJIJD3Yx9GOogiCM/UX9vtW4laEcfHGuvmauTcTsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs6IswhF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs6IswhF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2503753efso73147765ad.0
        for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776358039; x=1776962839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcIYmGJijp1gql4INlwnF9x0hUWvlgCOIk9cRqzHqwc=;
        b=Gs6IswhFpFwMI/ERCm8U6l3WR98FIXJah9YTA8vHWXIx+Ulshu7PSG49HXQv2Zl3wS
         5IJFP5cHsQezVotqKSQezux/TMHeZgaHC4bdhDUjFwl46ElNKR4KiXs9iBtEsWgxgmKE
         wCzC2yE3cjgZbI5/u6ij29/TMWWDK/sOqRID/g3LJU6lZH0n0zN31PZy0EdYSUI5XFBG
         lkz+IfFxscqgpnkbvfCQWdNnjzmDfjY2uT5SKjVDYAW7++ygXcV+fmgp46aUJ/6kWaMj
         /AVlWKJzZqceNWz0JFcFJPbCsmkjddJKG48xr8/VmLOktJZM1ViKvqcTREuxAs8Y3vuT
         opfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776358039; x=1776962839;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcIYmGJijp1gql4INlwnF9x0hUWvlgCOIk9cRqzHqwc=;
        b=MHgp68y0pKzsLIadShXgsmzCbOQVHsikWFc8PwNqil2oqiGSlF7tyCYNq+0hMnJO1x
         zirdBPHF9v8t16bCUEAZHNzDrwU3jewwR06IKO6Z2ecE8e/Z9kq/xUjPB1XQXmNM15hE
         uj9pWdSsgvvgWu1p4RL1mskFJFPlYcEh+ML7Qaz2zUP3l7McdjqGzBVb6nGX+dXy53H2
         zD292kW69DPnWPkFjAokhMBl2zLf0WsPG+pgN3ThOc8bM8s1nJix+3JGJqA1qx1z/gCN
         NDpJzSz7roHvt6XPGfkWgwc8DUszyPEMu/PIMbzYCx4gOitqlvVTAQiErSm5y5+7xPs2
         i/lw==
X-Forwarded-Encrypted: i=1; AFNElJ8hiEWZQdc/2tqUVTluMhUxDjqIA+0BTgWPQCoksP/m3HUNJeTp0wTnml+EcPYI6bmD1Iv5gXhd@vger.kernel.org
X-Gm-Message-State: AOJu0YzZahbN5YirVN96z/Gp4MY0yX1J5rdUEN946/KRS00c0A9rwGW0
	6cY5cbKct9CsTpHAZ0wIeE3lWQHi5rOrNQBH/qzHqigJS9QIH9iNo2kb
X-Gm-Gg: AeBDievdrN+SiRb4QMyn9ZsBYgCumnZR5YEnD00SPjgzDc14iTXoKD/1FBSpzGUJUje
	MdVF+2/vdbELAzgQNsNAF7LNG3JJDoC/eschk7zERU8l5rfrAHBWwdtWGciwRCifIoLAYvgjyWp
	MHpK+6Sl9z9A79T+zX/GIKrgPBdy03ycgpjXIKsSdJl9+oVIS59mhZt6ajbvD3nUKlpEhue19dT
	qT0TiS8RNzIEj0onAyNOkiYwcDYduhzoTsBaAwON6hrLHBmgf8EBs9U59YAmw5lBM7m4HP3smPM
	t1miXOeuruyXSiyMsU4rW43gehmY7RJrtvCAVrJR9Mp0dYEzGaDvLpjlXBqX8zRYkytA6eSrTVK
	l5461XkpmJbPnV6JUjKRJkPZfEPYK9+5sqAN4yloRr2qzmTi7eT4fpbjzy0yawjPn6lkvMJAdhc
	lAYjfBC4Q0Q/F3pi0dRKDM
X-Received: by 2002:a17:903:2ac3:b0:2b2:6b58:9317 with SMTP id d9443c01a7336-2b2d5a77878mr269003585ad.39.1776358038866;
        Thu, 16 Apr 2026 09:47:18 -0700 (PDT)
Received: from zlang-mailbox ([64.176.226.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47810ae96sm78015315ad.21.2026.04.16.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:47:18 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Fri, 17 Apr 2026 00:47:09 +0800
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Prusakowski <jprusakowski@google.com>, fstests@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, anand.jain@oracle.com, wqu@suse.com
Subject: Re: [PATCH] generic/050: handle f2fs as nojournal filesystem
Message-ID: <aeER8AIJZecuTLIc@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, 
	Jan Prusakowski <jprusakowski@google.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	anand.jain@oracle.com, wqu@suse.com
References: <20260410131821.991005-1-jprusakowski@google.com>
 <ad3zThMKaWZ65XE2@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3zThMKaWZ65XE2@infradead.org>

On Tue, Apr 14, 2026 at 12:57:02AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 10, 2026 at 01:18:20PM +0000, Jan Prusakowski wrote:
> > F2FS uses a checkpoint mechanism for metadata consistency rather than a
> > traditional journal. Roll-forward recovery is only needed if there are
> > fsync'd files since the last checkpoint.
> > 
> > In this test case, files are created without fsync, so there is no
> > roll-forward data to replay during mount.
> > 
> > Therefore, F2FS does not need to write to the device to recover, and
> > successfully mounts on the read-only block device. Thus, it should be
> > treated as nojournal in this case.
> 
> This looks ok, but I always wonder if we want an opt-in for this
> "journaling" behavior and/or define it clear in common/.

_has_traditional_journal ? _has_journal_replay ? :-D
