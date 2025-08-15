Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F73019C9
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272130; cv=none; b=s56xD8m6tmungdf9jGj0TmvmAxvSxxdp9y/t5QAF72wbxLUQYiJ00XvIhENWaVkPLTB0bEKdM3wDvWTY7lcjKpNEIcmvxiczKuXvUizdnXxmLV0mWrTtH7jVjlIdSpnI/wFy7g0uKjPrPumbPyl5tLt56KKlNgxkgdtmdX3k//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272130; c=relaxed/simple;
	bh=UcVBTkiaAfjyxhkAypowdU3iyMDAe18Z7PLGgK+DDbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8fTqwZ4slmtl8TPG+CY5dmsblkeYq3TqURuE2PhysBqY4jITuVUGIcWVB7RyBbxn7D27rMt0E2w7UhHwJeiSdb6MW8I6r4SUNbs8xTzMgKUjRdRTO07ocNoqfwOD5g2LFZybVuhN8ZUOKHcD+JNWJcgRHiSEgoJlo1Qa1XYU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAToBuWf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAToBuWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755272128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wajqPBBnPcom4Kwsxt/izQnxID9VykIZCvGlW/eXKBw=;
	b=aAToBuWfE0LBy/LfIYloF5XUe4iuHStaboOvvoESIMKBLKCtiyssCXwwAyRGoQ/Fs3R4vB
	1Luv5KjC9YNjvQQAtSwp7C1RxAhbitFjqNRj4Cc965wS1nivzM4+ukR7Y1RR3Hzh0dAB0T
	j7ySSDq5NLUj4ljUNrEMtyUaDgBkH8Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-nGc_8p8fOg-Xs0G4h3p1Cw-1; Fri, 15 Aug 2025 11:35:26 -0400
X-MC-Unique: nGc_8p8fOg-Xs0G4h3p1Cw-1
X-Mimecast-MFC-AGG-ID: nGc_8p8fOg-Xs0G4h3p1Cw_1755272126
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4716f9dad2so3177301a12.0
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272126; x=1755876926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wajqPBBnPcom4Kwsxt/izQnxID9VykIZCvGlW/eXKBw=;
        b=YN3lanAu5yMu2cmB1UU6AJXEkq6oWxLnCZgi9TS3zCrvWXoRE4Z5buLynthHagt9I1
         FgVAO4cwb7Li3DBiaI9JM3J1FlT6hyau5sfbSYD3WuhG9HP+5j4LhxNeGgtmi5B7H+6H
         jLfZTfAQcyHQ0+u3TknX6HUTXbVMFzDo4SYkiJDsdFOz7+DRzpJnUBW0rFRZu3ykZ3O7
         zTQEX3/bQWw1aoo0FDEgb6PqSvtMnxl31QRvjW7Or0C7qBvQJCpZNBstyUqZ5PA6wA8F
         Dlu4i5gYHdGUVllpRy+BEpFoDN2MVqMUNzUxabtzqVZ0kNSJRAkHEx8Eb3wABNc0UY42
         dpEw==
X-Forwarded-Encrypted: i=1; AJvYcCWM2/mDiI08oS7Utm7Z8UDQsnpDQQ5JhQGdmpEweC9JWNrD0dIgRdG0g/z6+xBae9A4B0vXeqD7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WtcDu3GT8F59bDMfzBxbg1IBPU2CKKAPsC9dea8HAlHjucYH
	KMy/KzhyE017QlHVaOowRiu3D8HlRynmzD5vy2YWcGIiJvLeaK/cYFx/r0Lq3/C0+2X1nO3275z
	Gind/7ABk1kMUnrMfW5WE95yCElcoKhbRtTXKvbfAn4rlYGxLKVKjs6pvST0=
X-Gm-Gg: ASbGncvVJc3gTip/ETCKb6loX1M9ic6U5fsg9FUrcJFpGCdNgbtM9O78D8Z1TP7ACCO
	sJgM6VAzxFFzNnVIf2+5MXajjc0OhD3MrMJ2n3WNFdfx+4Ukogm1xw/pSAsU4v4sjk5speOwGgF
	XfZti91RhkVWI/jvkFbumW5wRsWEQA6sbWGgsZH/uIdY2I/HBQkR3rsOC1g0Q+N9b25sDb3JEC3
	8Sh4msS87OYORofgYHmMearDR5BpDZ3HA4c/m8vs+FSJzCj1GA4E5yz4dXjrYPTIBXcmUss5pTQ
	j72sLyv2fCR1KfpTZQBEd4XZwbtdeomIVboYS8UIEBMDWrA055BDDmdVqENzQpHPtzaNw7eNmmL
	dg1JG
X-Received: by 2002:a17:903:388e:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-2446d5ba0b8mr36712695ad.8.1755272125825;
        Fri, 15 Aug 2025 08:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/MOn3qFUjwT6lp/UsjitKwU3PZP0ZcsExwJyu+bqYbZ/DIyeuHTJ0dBeCqaDT2K6ORexiKQ==
X-Received: by 2002:a17:903:388e:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-2446d5ba0b8mr36712445ad.8.1755272125452;
        Fri, 15 Aug 2025 08:35:25 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f2d4sm16627635ad.102.2025.08.15.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:35:25 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:35:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-unionfs@vger.kernel.org, pdaly@redhat.com
Subject: Re: [PATCH] overlay/005: only run for xfs underlying fs
Message-ID: <20250815153520.xzgxwuwc7slt34li@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250815144555.110780-1-zlang@kernel.org>
 <CAOQ4uxjVpVPVfiJPokpmu6pLDmjtYbeDr+j5jNHi8k9bK_2feg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjVpVPVfiJPokpmu6pLDmjtYbeDr+j5jNHi8k9bK_2feg@mail.gmail.com>

On Fri, Aug 15, 2025 at 05:16:51PM +0200, Amir Goldstein wrote:
> On Fri, Aug 15, 2025 at 4:47 PM Zorro Lang <zlang@kernel.org> wrote:
> >
> > When we runs overlay/005 on a system without xfs module, it always
> > fails as "unknown filesystem type xfs", due to this case require xfs
> > to be the underlying fs explicitly:
> >
> >   $MKFS_XFS_PROG -f -n ftype=1 $upper_loop_dev >>$seqres.full 2>&1
> >
> > So notrun this case if the underlying fs isn't 'xfs'.
> 
> It would have been better if instead of mkfs.xfs, we would have
> used a helper to format $upper_loop_dev as $OVL_BASE_FSTYP
> 
> But this is easier, so unless anybody wants to take on the better fix
> 
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks Amir, No matter what kinds of underlying fs are all good?

I saw this case use:

  $MKFS_XFS_PROG -f -n ftype=1 $upper_loop_dev

So I thought it need the xfs ftype feature :-D

> 
> Thanks,
> Amir.
> 
> >
> > Reported-by: Philip Daly <pdaly@redhat.com>
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  tests/overlay/005 | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/overlay/005 b/tests/overlay/005
> > index 4c11d5e1b..d396b5cb2 100755
> > --- a/tests/overlay/005
> > +++ b/tests/overlay/005
> > @@ -31,6 +31,7 @@ _cleanup()
> >  # them explicity after test.
> >  _require_scratch_nocheck
> >  _require_loop
> > +[ "$OVL_BASE_FSTYP" = "xfs" ] || _notrun "The underlying fs should be xfs"
> >
> >  # Remove all files from previous tests
> >  _scratch_mkfs
> > --
> > 2.49.0
> >
> >
> 

