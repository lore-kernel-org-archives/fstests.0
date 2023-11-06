Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F26B671
	for <fstests@vger.kernel.org>; Mon,  6 Nov 2023 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="orzdhSeW"
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B06DB
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 22:26:18 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c3077984e8so3420597b3a.0
        for <fstests@vger.kernel.org>; Sun, 05 Nov 2023 22:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1699251977; x=1699856777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs8EyB85nlBUE5TSiBTkXaWpXa4Ucxuzf7Wsqr/jcc0=;
        b=orzdhSeW35jEEcgWH8uiHHKpeQ8XIpHpD4vJgFcg2hBVCPDf2teCM235FFRuZgFD+M
         gCkuvEew9lbaDWUl9r7NtJNhNwFLIrVaedLKwNzQQi/wKu+d8roUBDUAlkgO3ZH4Yi5m
         J2aNgbD07FIfcBHB+oPVrgW2TNiTfxVN6qtDBFbs7RF450+iub5UAhrzXGawo7vzNn9A
         DxJyFInRLkzPs8d7Bmx6FEk3oUuGLje3rH7Ub1B4BPV7PT0N5kQEDteFO/8d0+Hsmh6X
         x+1dMwZBaMoURPe+uJEfR0WkyfRL3qezy+5/kaUhCjO9DYR3TbP4M5KkbBsjGAgY4z+c
         g/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699251977; x=1699856777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs8EyB85nlBUE5TSiBTkXaWpXa4Ucxuzf7Wsqr/jcc0=;
        b=mkIyGd7/60t/zJ59ydgsMziBArMy+31621MqapVtVXmcnKzOHzs6fFWCez77k+Q4wU
         34qQL70UfI1Ac1MvscSsqZ0bDRlKl/Lb0L+8lW7tX5ZK+7gqzxHhZTpBWQ0xxnJII/XN
         9dl2O4ASiOI3Lp7M3PJm1JhhMwbpru0W3Kv/8sO21wwQPNqQsSduMXg1gIDVC03Qr7C2
         jO1TRlE7WeR94F2ZGViEL9j1Ya96KSfDdbJJdu/yfzxvLcnmOObgNBosGpqjbAB2yPWD
         Dt+o8HEqgged2I24isgVjh61MAvGvxJaOHXqOT9rIRCuzoVcwlPXWGIiqAk86pkDu3/X
         bn9Q==
X-Gm-Message-State: AOJu0Ywcj2NQVNgI5y7wZ3y9/YUna0jZOXDVgDpKK8Wxb3C+7Pp6XZaQ
	R/o8hOlrw1CEenzKuvVd08NPwg==
X-Google-Smtp-Source: AGHT+IGeUIFQqGN3DiVhdgjAa2fPVCK7a9HtcSSSgdtkKgdvqa2gboNZOgopPu5KhXFAJeenCXuXGQ==
X-Received: by 2002:a05:6a00:1741:b0:6c3:41fd:3a3e with SMTP id j1-20020a056a00174100b006c341fd3a3emr9208340pfc.27.1699251977419;
        Sun, 05 Nov 2023 22:26:17 -0800 (PST)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id fa30-20020a056a002d1e00b006bdd1ce6915sm4889877pfb.193.2023.11.05.22.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 22:26:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qzt3u-008ruE-0r;
	Mon, 06 Nov 2023 17:26:14 +1100
Date: Mon, 6 Nov 2023 17:26:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-s390@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [Bug report] More xfs courruption issue found on s390x
Message-ID: <ZUiHBpJTUr3G4//q@dread.disaster.area>
References: <20231029043333.v6wkqsorxdk2dbch@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029043333.v6wkqsorxdk2dbch@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Oct 29, 2023 at 12:33:33PM +0800, Zorro Lang wrote:
> Hi xfs folks,
> 
> Besides https://lore.kernel.org/linux-xfs/20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#u ,
> 
> I always hit another failure on s390x too, by running generic/039 or generic/065 [1]:

g/039 is a sync + fsync + flakey remount+recovery test.
g/065 is a similar by more complex test.

So that's 3 fsync + shutdown/recovery tests on s390 that are now
failing with ip->i_nblocks not matching the extent tree state after
fsync-shutdown-recover.


> 
>   XFS: Assertion failed: ip->i_nblocks == 0, file: fs/xfs/xfs_inode.c, line: 2359
> 
> More details as dmesg output [2] and .full output [3].
> 
> And ... more other kind of failure likes [3]:
>   XFS: Assertion failed: error != -ENOENT, file: fs/xfs/xfs_trans.c, line: 1310

ANd that one is from g/509 after a quotacheck is completed and then
the fs is shutdown, resulting in dquots not being found after the
journal has been recovered and unlinked list recovery is being run.
i.e. unlinked list processing is tripping over missing file data
extents after recovery.

> All these falures are on s390x only... and more xfs corruption failure by running
> fstests on s390x. I don't know if it's a s390x issue or a xfs issue on big endian
> machine (s390x), so cc s390x list.

IOWs, all four of these issues are the same problem - journal
recovery is not resulting in a correct and consistent filesystem
after the journal has been flushed at runtime, so please discuss and
consolidate them all in the initial bug report thread....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
