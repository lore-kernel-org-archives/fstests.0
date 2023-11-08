Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274A7FD
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="dWExTNyi"
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB3185
	for <fstests@vger.kernel.org>; Tue,  7 Nov 2023 22:39:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-280165bba25so4884345a91.2
        for <fstests@vger.kernel.org>; Tue, 07 Nov 2023 22:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1699425543; x=1700030343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulun+lAbrpCzT3jYibtLBhBSSSJOwuFULkmqLToMbfw=;
        b=dWExTNyiHn2obDBmsIPY9OJSl43A6Y/gFsUs5fd34ACkPEg4D6SEwzYgmaUfZQL8UR
         JgYrKwEz6WZPVrEGef5b4sdsgZBLSXkAaF0ehbpXJIzEMbsN4VfA9l+wIHwCTK58bEgW
         DlBzQKkD16+m7jXMaDmm8BW/2IEnEPXc+wT6xmVKReD3V6IAVqYQy0/UAHryXaldUf3v
         ZNtWWY2yP7FsrCTcEsxdKX+92NEdIT7nsXLmleD5rU7Wp0/F4e7PkA7FK6gFuvWHIZQh
         jPtrqbR5e/vOn+5OmWhvwmQZyKJVckU45gxvA9eRzl10sxtCHMfuH7sY58AyVXpzYV+F
         fN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699425543; x=1700030343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulun+lAbrpCzT3jYibtLBhBSSSJOwuFULkmqLToMbfw=;
        b=vC5G6fiS/8fyku12bvsMBFl2bx5HZ+2F2XpdaxtduYjpRBaYA6J8Ydo8azyDMA2Jds
         yrCAxV3RqdapeKjEVuwvvfMf/3YtLm57hi7AWTHBhGBAZaOhE+jGxYsJY1P1tAXa/tqL
         VfiFLmoYg8OCRu9l0ZWMRw8SK40QHcONR85Wf1SbDkHZL6JGO2w/sLJ+xAPhcu+Q9yGH
         QQEDxO/4E/lnWx/ZwleJSgbN8gzFR7VSqZ8vWPitUMXHtUNrFnbOY/ibIEWc0nHzDgxo
         x8QQdKL5d8wC/Cjs3EMao5b6LxRwhreaMs0tvTN1uD0Mk9e3utShhEY/FnDxTz0q6LX0
         6gjg==
X-Gm-Message-State: AOJu0YwfVovWNuRdvUqBsGOJ1uXCWw1FMJP++C8LpiHR/nM7WD4A7QGu
	wSS3aJ2rIgOFtBtPknGvTrmey27ik/SzoXsmVQQ=
X-Google-Smtp-Source: AGHT+IFFXJRBYVp5XA8NqYmfcQEmH+2vIgwctQ/wSElrMSTmuOY4QZZ/bILqMsNl9Frv0O+fCXZPcg==
X-Received: by 2002:a17:90b:3a89:b0:27d:2364:44f6 with SMTP id om9-20020a17090b3a8900b0027d236444f6mr933982pjb.6.1699425542754;
        Tue, 07 Nov 2023 22:39:02 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090ace0300b00274b9dd8519sm850961pju.35.2023.11.07.22.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 22:39:02 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r0cDL-009lJd-1M;
	Wed, 08 Nov 2023 17:38:59 +1100
Date: Wed, 8 Nov 2023 17:38:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <carlos@maiolino.me>
Subject: Re: [Bug report][fstests generic/047] Internal error !(flags &
 XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.
 Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]
Message-ID: <ZUstA+1+IvHJ87eP@dread.disaster.area>
References: <20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUiECgUWZ/8HKi3k@dread.disaster.area>
 <20231106192627.ilvijcbpmp3l3wcz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUlNroz8l5h1s1oF@dread.disaster.area>
 <20231107080522.5lowalssbmi6lus3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUnxswEfoeZQhw5P@dread.disaster.area>
 <20231107151314.angahkixgxsjwbot@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107151314.angahkixgxsjwbot@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Nov 07, 2023 at 11:13:14PM +0800, Zorro Lang wrote:
> On Tue, Nov 07, 2023 at 07:13:39PM +1100, Dave Chinner wrote:
> > On Tue, Nov 07, 2023 at 04:05:22PM +0800, Zorro Lang wrote:
> > > On Tue, Nov 07, 2023 at 07:33:50AM +1100, Dave Chinner wrote:
> > > > On Tue, Nov 07, 2023 at 03:26:27AM +0800, Zorro Lang wrote:
> > > > > Thanks for your reply :) I tried to do a kernel bisect long time, but
> > > > > find nothing ... Then suddently, I found it's failed from a xfsprogs
> > > > > change [1].
> > > > > 
> > > > > Although that's not the root cause of this bug (on s390x), it just
> > > > > enabled "nrext64" by default, which I never tested on s390x before.
> > > > > For now, we know this's an issue about this feature, and only on
> > > > > s390x for now.
> > > > 
> > > > That's not good. Can you please determine if this is a zero-day bug
> > > > with the nrext64 feature? I think it was merged in 5.19, so if you
> > > > could try to reproduce it on a 5.18 and 5.19 kernels first, that
> > > > would be handy.
> > > 
> > > Unfortunately, it's a bug be there nearly from beginning. The linux v5.19
> > > can trigger this bug (with latest xfsprogs for-next branch):
> > 
> > Ok. Can you grab the pahole output for the xfs_dinode and
> > xfs_log_dinode for s390 from both 5.18 and 5.19 kernel builds?
> > (i.e. 'pahole fs/xfs/xfs_inode.o |less' and search for the two
> > structures).
> 
> I can't find xfs_log_dinode in fs/xfs/xfs_inode.o, but I can find both structures
> in fs/xfs/xfs_inode_item.o, so below output base on:
> 
>   # pahole fs/xfs/xfs_inode_item.o
> 
> The output on v5.19 is [1], v5.18 output is [2], the diff of 5.18 and 5.19 is [3].

Ok, so there's nothing wrong with the on-disk format definition or
the journal format - they both lay out in exactly the right shape
so I think at this point we need metadumps from the broken
filesystems.

Can you pick one of the failing tests and grab metadumps from
the shutdown filesystem (i.e. before it is recovered) and then
another from after it is recovered and the problem tripped over?

I know I won't be able to replay the log on x86-64, but knowing what
is in the journal vs what ends up being recovered will tell us
where to look next.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
