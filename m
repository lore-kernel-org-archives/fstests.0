Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D1DDAB
	for <fstests@vger.kernel.org>; Tue,  7 Nov 2023 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FjuESj6n"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCB8EA
	for <fstests@vger.kernel.org>; Tue,  7 Nov 2023 00:13:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc3542e328so36830295ad.1
        for <fstests@vger.kernel.org>; Tue, 07 Nov 2023 00:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1699344822; x=1699949622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46M3USSEzH3qj0JXRJ2zukFaRMokdHms1lrmTSJWQWs=;
        b=FjuESj6nYw+66VcfS0kKeohUIFErwpRh5T5xlrdya5CRofzOCXIWfw5ySEvfsCWXVB
         pPb04BnnSMJrdG/aBjk3rEF9ulFj2H6R8ucSg5QXJy/maWpfN0PrVgV0+dkVCnp8hjjZ
         74E0jzPwesTauAsOGP1sXee0AJrpsLg+tfeG42m3Wy+qyZLNVq6iODK+8OTO3FNVzOas
         pwq577MqZoDvCbrhvjKMN8qvKTVQcnHKzSuphxLOs0S0IYHWe/sfp6a1JN+qwtWpf6i+
         JRlc54PRvvso0/d+mGxa8OfxP1JWZxrqm+5heJsTgw+4z/ioVNrIOCTMOWi8U4dC5EtH
         RN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344822; x=1699949622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46M3USSEzH3qj0JXRJ2zukFaRMokdHms1lrmTSJWQWs=;
        b=h53t3BKpKvRiSPJdC0tV4rLWilfW6CrcrSlu0kkSo8yUrbYLetwKRJMGK96gJyayN6
         OkiXzvGNde4WpLLxpK+dMA5jcsDxfooKtwYUL835hLVlLBqXdHz3nz/PUI8lB+hFRjOJ
         5ZlUA0vu1+V8O8xgHRKmCFu3J+L3dPNyL/oH20hbi+X8PXQS2g5afEYc39Ou7y8VeJWd
         tExblVQicybTP9YTeI9rUjBU220FLm57tb/mT9g72dl6/heWCUAD2MEElUSIPemZgriu
         C8bIyAQ5qRezNmY2pq/N5nr8mpfifSVGRZXHoz7QnhPMSOSW+MRlmo0dW1fhd7hHOOAE
         4eng==
X-Gm-Message-State: AOJu0YwdnBelsM/0ym/0QHDAcUjjdYA76MJ3szovy8AXQUctrUHwGnix
	m3nliEYUlwcd5ziSWGhrUSWDBw==
X-Google-Smtp-Source: AGHT+IFXbf58W9Bxg3ZOTP+lTRhHZHhRxm+1h9inhYKIDvMJ1PCV0UNWZib5qtRxD8GH2ITviXinIA==
X-Received: by 2002:a17:903:22cc:b0:1cc:6acc:8fa0 with SMTP id y12-20020a17090322cc00b001cc6acc8fa0mr21901650plg.34.1699344822342;
        Tue, 07 Nov 2023 00:13:42 -0800 (PST)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001ca82a4a9c8sm6985460plt.269.2023.11.07.00.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:13:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r0HDP-009LBD-09;
	Tue, 07 Nov 2023 19:13:39 +1100
Date: Tue, 7 Nov 2023 19:13:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <carlos@maiolino.me>
Subject: Re: [Bug report][fstests generic/047] Internal error !(flags &
 XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.
 Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]
Message-ID: <ZUnxswEfoeZQhw5P@dread.disaster.area>
References: <20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUiECgUWZ/8HKi3k@dread.disaster.area>
 <20231106192627.ilvijcbpmp3l3wcz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUlNroz8l5h1s1oF@dread.disaster.area>
 <20231107080522.5lowalssbmi6lus3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107080522.5lowalssbmi6lus3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Nov 07, 2023 at 04:05:22PM +0800, Zorro Lang wrote:
> On Tue, Nov 07, 2023 at 07:33:50AM +1100, Dave Chinner wrote:
> > On Tue, Nov 07, 2023 at 03:26:27AM +0800, Zorro Lang wrote:
> > > Thanks for your reply :) I tried to do a kernel bisect long time, but
> > > find nothing ... Then suddently, I found it's failed from a xfsprogs
> > > change [1].
> > > 
> > > Although that's not the root cause of this bug (on s390x), it just
> > > enabled "nrext64" by default, which I never tested on s390x before.
> > > For now, we know this's an issue about this feature, and only on
> > > s390x for now.
> > 
> > That's not good. Can you please determine if this is a zero-day bug
> > with the nrext64 feature? I think it was merged in 5.19, so if you
> > could try to reproduce it on a 5.18 and 5.19 kernels first, that
> > would be handy.
> 
> Unfortunately, it's a bug be there nearly from beginning. The linux v5.19
> can trigger this bug (with latest xfsprogs for-next branch):

Ok. Can you grab the pahole output for the xfs_dinode and
xfs_log_dinode for s390 from both 5.18 and 5.19 kernel builds?
(i.e. 'pahole fs/xfs/xfs_inode.o |less' and search for the two
structures).

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
