Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FF2E3AED
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936499; cv=none; b=RtB1i471taEvh2cwh7oV0RsAa0nYKWeMjlqQu1fcq9TofGF9WiQXA+6ETswiS8WYfVtzMpDSEHpMrp5FT3sLclwAWBHNSvZuKnGR5JlLd7Cd4mbONFm9qonKhgeA+FuSO47Mg19K9TTk0mbs/jC1+qCVcMj7JSSSuz3rAPzVWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936499; c=relaxed/simple;
	bh=s2bacoZ80gq553nMZNXudTEIwsP2I7+dIcU0QZgpf6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWm95/Hw/3Aopd80hBgzseElPbZ+h6O/zYzjy8JHuoqBUtyijWVkWlea9prDTa2ETKQh/7AnCSuHJFqTKLYaY+t192VVfL/3Q/nd4jvdACcdsbZf4dzOdHoHLsTEY4UjunHPYPwlolKYnPuHvY0IA/n38TrCcNenloxAgknAfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKaSY2eB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKaSY2eB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fwTrd0+dO6n2K9dOFuwOVngF2++TGNcYuAwM4GZHZDU=;
	b=dKaSY2eBOzEOOZwhOnvWOyuXj/A20PV+q1xGCa40qnqznCncYHuMNHRKylRZHeSfuX1P07
	n6IuG4dsVkK/8nqx5sgqkN8B+mGvc2+0dD6r/g0L/GiKnietTcjNOLK1vQrYjugIGwbDIk
	rnjBcqLgx3E2np1gMLGC7TgkuaOHJ4U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Ln6xIUVbMGWdn9LxC9Sqfg-1; Mon, 11 Aug 2025 14:21:35 -0400
X-MC-Unique: Ln6xIUVbMGWdn9LxC9Sqfg-1
X-Mimecast-MFC-AGG-ID: Ln6xIUVbMGWdn9LxC9Sqfg_1754936494
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b780da0ab6so2352874f8f.0
        for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 11:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936494; x=1755541294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwTrd0+dO6n2K9dOFuwOVngF2++TGNcYuAwM4GZHZDU=;
        b=v0QwX/GtPxPSzkEcPKViO+GxalnQHPr7Ub+Q7B0XjfuOOFyd+n67Bkj33Ns4HprSnc
         lYOeutXXIYws/r+LeDlxIeKaSzaJH1EVMcSXo9m2EWMedom6CLgBlLnS6PjBux76lNpZ
         RGFbyiKFTtBfD7b/McnaaPRVfpA6QjtN1XJwju8p02F5NhYqD0lM/ZfQB9NZhx+5yLn8
         Q9zajuxF3kxJJ9unTvEGfx/onx6toSuofs/tsRKffyl1v5tlIRGDYWQGHcV3JU5/yKD3
         TYSlVkOe4GpEg30nv4x+DarU1Mw5LdVSFloyaKwpAtZIKRtAK88QQIQaYKne66Ay4hBa
         /Ddg==
X-Gm-Message-State: AOJu0YwEY+zwPFtmhsIqrJ4H3ljO2Y4enC0ii3y5XtkydMUqDEp59bBp
	nwkfWTa+y76waNy0eVoXtaioRcjYdpyp8iQnh67QmIWkaLgtzoLSGFKKIpCREoco61Ga18lOLtb
	zK+p/I/IzBu+WscMW0QVL+5wGsy0H5yqHcw2Q3CO9HNaCV02STWqdyjk+vQ==
X-Gm-Gg: ASbGncvfWB40Anttah3v0rjR7/nLj6himlOTVRejIWbX0GeiI1Pk6/vv2Npb23o3/Oz
	OQ7h12oOyv6yXATS83bDJCFc6m2UL1see2qkGo6yICMYRbfBM3ys8UicHgo4m6EPdLkKVpm+Jly
	3zSzFvFA2j5IWmN5jwQMN5hRgolmpWijcTDALpueJuVBrVeNB1nSpXQ0nP2k2pyDsO1o+NKpsZS
	k911UP9bNZXygePOP5c/wQqiWeX8/77mB98pXzVaM8tacH5sGWEp8NXJWKnkrgd2jvhtSTIMYaT
	3HJ/7xifEyAo1/sMF4UIp+wCnWr72R+dNRHLMcR80QXPhR1EUPe66hIDZGo=
X-Received: by 2002:a05:6000:2f86:b0:3a5:39bb:3d61 with SMTP id ffacd0b85a97d-3b911007af1mr404472f8f.27.1754936493845;
        Mon, 11 Aug 2025 11:21:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB8j2u3EX4ITM1fOLXGqpgPLkv5CcVqBQNtd//Kju257Gmpgop9iCOpmn/23WDZQFXeta5Ng==
X-Received: by 2002:a05:6000:2f86:b0:3a5:39bb:3d61 with SMTP id ffacd0b85a97d-3b911007af1mr404458f8f.27.1754936493441;
        Mon, 11 Aug 2025 11:21:33 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5852e28sm260580235e9.9.2025.08.11.11.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:21:33 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:21:32 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, zlang@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 3/3] xfs: test quota's project ID on special files
Message-ID: <gyajh6rvjyqq5z4acrk2um4bwkarxztu5ptuyyehrh3xqcffwg@q3nh34dkdpwo>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-3-6a09c4f37f10@kernel.org>
 <20250811152109.GF7965@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811152109.GF7965@frogsfrogsfrogs>

On 2025-08-11 08:21:09, Darrick J. Wong wrote:
> On Fri, Aug 08, 2025 at 09:31:58PM +0200, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > With addition of file_getattr() and file_setattr(), xfs_quota now can
> > set project ID on filesystem inodes behind special files. Previously,
> > quota reporting didn't count inodes of special files created before
> > project initialization. Only new inodes had project ID set.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  tests/xfs/2000     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/2000.out | 17 ++++++++++++
> >  2 files changed, 94 insertions(+)
> > 
> > diff --git a/tests/xfs/2000 b/tests/xfs/2000
> > new file mode 100755
> > index 000000000000..26a0093c1da1
> > --- /dev/null
> > +++ b/tests/xfs/2000
> > @@ -0,0 +1,77 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Red Hat.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 2000
> > +#
> > +# Test that XFS can set quota project ID on special files
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quota
> > +
> > +# Import common functions.
> > +. ./common/quota
> > +. ./common/filter
> > +
> > +_wants_kernel_commit xxxxxxxxxxx \
> > +	"xfs: allow setting file attributes on special files"
> > +_wants_git_commit xfsprogs xxxxxxxxxxx \
> > +	"xfs_quota: utilize file_setattr to set prjid on special files"
> 
> These syscalls aren't going to be backported to old kernels, so I think
> these two tests are going to need a _require_file_getattr to skip them.
> 
> --D
> 

will replace it here and in generic/ test

-- 
- Andrey

