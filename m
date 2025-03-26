Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03A111BF
	for <fstests@vger.kernel.org>; Wed, 26 Mar 2025 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742950079; cv=none; b=mlE1ptNoHFF1i5Z0jh8nJB6U6tBBHmbDwbrsbt4EMzQZR8+PjcUBWkuCXN6z02bLoKSeGflIqYV5nU1QJdcS6bpnVOiozt9au2Wij/ewGw3od2DgfYm3EbUULJ5Um+w1MnZTcoh+PBqLjqsl/8y0+MG7S3V2QzuoCRGY2bu4tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742950079; c=relaxed/simple;
	bh=QhPrTHZdjwvQkQ1Q5PAMBV4B0c0eEPiPjD5beLYYX+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWe0D0fzAJw7v3B/m98QhA0ViGCKxz1zFw1c26QvlbGgFk3YzPW7XtnbIMXnxGn9HpZd6wGYFiVMAJYsi0JRm92Zquq5l3ZXiwOSyOsMry71zOkds7xBCHyERo2HC+w7UogpVdApvSFwD55zN+zHPS2YDhaNdcHDSvYVQgJX8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5n2LI8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5n2LI8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742950076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4KHyk1+MRQuxC+eJ9QzulpisBcombtQV4ojfnxT6JVo=;
	b=M5n2LI8BkzKBg7lLtGWQjcmLwN7XKz7Kxk9eTWds20r84+U1N0cmnxSXpCkt1gQEoJgwKO
	Tmnn1KAejWWTjDJWnlgQroXKPIRDVkPKREuM4mTlCrBgtc57SqxQY7zsaoPITYsxezMk57
	rA1NMBarT07ba6v5vGAdToHJMsFrWog=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-b2PDoHHLPrOpMVIMRaH7jA-1; Tue, 25 Mar 2025 20:47:53 -0400
X-MC-Unique: b2PDoHHLPrOpMVIMRaH7jA-1
X-Mimecast-MFC-AGG-ID: b2PDoHHLPrOpMVIMRaH7jA_1742950073
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2265a09dbfcso162836085ad.0
        for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 17:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742950072; x=1743554872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KHyk1+MRQuxC+eJ9QzulpisBcombtQV4ojfnxT6JVo=;
        b=ClXvaBd+Se0UaU2sUpwK0BICmgiDISDAMZ5BIDKcRoNxpQbGwhJ4Bpn/W49KYgoP1j
         LNnHobjSH3UYG9Lv5Pp9DLZhuNedt5sLp8kaGgb6UGsSGQ98TazeN5rK7sadfujyg8Nn
         aQ0xek1rEMGZ/nQAq1PwEMLlyIXJDmyWnoM1csRjoEZmcvpY2aTodQvpEqsDiqCtZFcU
         Ynaoc00UXecKyuL9qZ4xvyxchp89jZzj4Dy5uwVGO+qiuE2MIcCcvpmt/DtPlLTxgP+R
         f1JxqAmfT3gDI1UWkcTBnxmLqZ4qvoLxheLAFEdUmhhjaYQY+793Vmv8Lo/gGdAxgeJu
         jmDQ==
X-Gm-Message-State: AOJu0Yw5zDcyGiW8iLUeI6MV7qpzp7Wolj3GA5+0lSgtmpbsOIcAJ3kF
	5H3d9Qp2tlE6sKMsEzSykFrGRoiPkcnpZvYlXzhjfH48n3pukxv1e+1+rkbeo1fYUE8TWao/4cC
	hqGZNFMAvxGkTo61JlvLMjg4alAw3BCxfgycCbcrs/I3CDdmO9RPlEtk=
X-Gm-Gg: ASbGncv+EpIBaja44QdhsM5u3/48vfQyRM2wUsLj5qmMbxT+FIghCMRQlRjVD3GXtf6
	wVij+H5YMiYh36nD9QzcMRGV1gDa32AMuMsWVGnMWnxCa5Mv1CYx3KhcYmxfeKaaYFYxJZjQtz8
	v42jebGtybR+0woSl7urRks5DMQhrvGNO8NR7cVAVmWugWJ8I1kuXh0wOeWHCjhtUIrmErsXy+a
	gGlxKTLGKfwBrYns+qe6uDFkkFRhZndoY42Em+vAuF7J3w6RKNAxpDOErb8pGr3x+jcQ4hoy9yn
	PQLbXxNFRV9/StSNQJbA4zZu3n+usKp4peeCMtJ1pCWHphaaDdbtZ+TE
X-Received: by 2002:a05:6a00:14d1:b0:736:728b:5f1f with SMTP id d2e1a72fcca58-73905a140b0mr25926452b3a.19.1742950072653;
        Tue, 25 Mar 2025 17:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCvdk9I2rUhFXerNCzyrQucBGAY0/7qw28RR08tM8XnBkghbtmD6M8PrQvM6kBEW6czcrE0Q==
X-Received: by 2002:a05:6a00:14d1:b0:736:728b:5f1f with SMTP id d2e1a72fcca58-73905a140b0mr25926425b3a.19.1742950072169;
        Tue, 25 Mar 2025 17:47:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd7a3fsm11261915b3a.67.2025.03.25.17.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:47:51 -0700 (PDT)
Date: Wed, 26 Mar 2025 08:47:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>, Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 6/6] f2fs/009: detect and repair nlink corruption
Message-ID: <20250326004748.bx2z62lpqpg6rjlj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250325125824.3367060-1-chao@kernel.org>
 <20250325125824.3367060-6-chao@kernel.org>
 <Z-M6PkLZI2LIOlXY@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-M6PkLZI2LIOlXY@dread.disaster.area>

On Wed, Mar 26, 2025 at 10:20:30AM +1100, Dave Chinner wrote:
> On Tue, Mar 25, 2025 at 08:58:24PM +0800, Chao Yu wrote:
> > This is a regression test to check whether fsck can handle corrupted
> > nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> > and expects fsck.f2fs can detect such corruption and do the repair.
> > 
> > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> > v5:
> > - clean up codes suggested by Dave.
> >  tests/f2fs/009     | 141 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/f2fs/009.out |   2 +
> >  2 files changed, 143 insertions(+)
> >  create mode 100755 tests/f2fs/009
> >  create mode 100644 tests/f2fs/009.out
> > 
> > diff --git a/tests/f2fs/009 b/tests/f2fs/009
> > new file mode 100755
> > index 00000000..864fdcfb
> > --- /dev/null
> > +++ b/tests/f2fs/009
> > @@ -0,0 +1,141 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> > +#
> > +# FS QA Test No. f2fs/009
> > +#
> > +# This is a regression test to check whether fsck can handle corrupted
> > +# nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> > +# and expects fsck.f2fs can detect such corruption and do the repair.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +if [ ! -x "$(type -P socket)" ]; then
> > +	_notrun "Couldn't find socket"
> > +fi
> 
> Perhaps something like:
> 
> _require_command $(type -P socket) socket

Good point! Maybe double quotation marks -- "$(type -P socket)" is
helpful, due to if socket isn't installed, there will be only one
argument.

> 
> would be more consistent with all the other code that checks for
> installed utilities that a test requires?
> 
> > +_require_scratch
> > +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> > +
> > +_fixed_by_git_commit f2fs-tools 958cd6e \
> > +	"fsck.f2fs: support to repair corrupted i_links"
> > +
> > +filename=$SCRATCH_MNT/foo
> > +hardlink=$SCRATCH_MNT/bar
> > +
> > +_cleanup()
> > +{
> > +	if [ -n "$pid" ]; then
> > +		kill $pid &> /dev/null
> > +		wait
> > +	fi
> > +	cd /
> > +	rm -r -f $tmp.*
> > +}
> > +
> > +_inject_and_check()
> 
> Single leading "_" is reserved for fstests functions, not for local
> test functions.
> 
> Just call this one "inject_and_test", because that is what it does,
> and call this one:
> 
> > +inject_and_check()
> > +{
> > +	local nlink=$1
> > +	local create_hardlink=$2
> > +	local ino=$3
> > +
> > +	if [ -z $ino ]; then
> > +		ino=`stat -c '%i' $filename`
> > +	fi
> > +
> > +	if [ $create_hardlink == 1 ]; then
> > +		ln $filename $hardlink
> > +	fi
> > +
> > +	_inject_and_check $nlink $ino
> > +}
> 
> something like check_links()
> 
> Otherwise this is a good improvement.

Hi Chao, if you agree with all these changes, and don't need to change more, I can
help to merge this patchset with above changes. Or you'd like to send a new version?

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

