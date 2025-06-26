Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E102F0E32
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967638; cv=none; b=ElwwD/Q55+AQ+4XbhbNO4BKIVoKF9F+S/5bQQ99qcjQeDxgwNsVPfpJXYI030l+T9MsbFZ2Bq9SVpbipeEU6nPksGgPQWn03AalR/9RqsZ9eZUVO6Bb4607b74MMpwtMQG3XcGCtD6rQjkPfzA07axnH0lRblyfMLjB+hEsDx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967638; c=relaxed/simple;
	bh=f9CwWMff4QXbVHW9cZdRc4cB27oFc6Aq8eFF5yj9+F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrHs9PE3v4YN93v9fOaJBhLKLdM18eZcmYl7GDzseZM6fFbiGav0vGKRwildFuz5GQ85J9a3LwoQbMqoIqt62FH7bQNV9duYMHU6hFMF1JrHMgfAxUejt3qYNuJSGGyKPrOdmad/G34p9D5zNV/dPhA/bzUBm38jJLz0WG3FHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggYo3AnS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggYo3AnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750967634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/nLmVsdZrAYBKvHYS4BNJcLEavliBujZLyQxb0TY/8=;
	b=ggYo3AnSzD93tJesQtFcl7/jtbFdBSCXcE+53ERiAO5A9EN/V8Dtczx3sFECHCPrH7yBtP
	2zMjOhEoVE2G8hrKRhg/xIFfCvq4PxuUJ68GdEEiHQTFH6xH/JwurudubXltLH5IWTLAjN
	sJgRG9Gi1xnGw9cDmZO67+mI6+Vfvgk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-s0-zDWseMHSPQC802-quHQ-1; Thu, 26 Jun 2025 15:53:53 -0400
X-MC-Unique: s0-zDWseMHSPQC802-quHQ-1
X-Mimecast-MFC-AGG-ID: s0-zDWseMHSPQC802-quHQ_1750967632
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74890390d17so1168756b3a.2
        for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 12:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750967632; x=1751572432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/nLmVsdZrAYBKvHYS4BNJcLEavliBujZLyQxb0TY/8=;
        b=Z9Q9bpXB5v8tLChXrvvkzCd+aNinoKZd1kidKhoXW0i0D0ylT3UuSzganGroezzx65
         /VioRs31FSV+9lUEddHED2Pu0xfCfCMZm9joqHHl6G5WalRorgbvX7cGC/I+HbkVAMaC
         mYZz/SJgki3lo43IqJWO4SRZRMkfTe+Fu8hBMkRKEKpHdLCXq2RtVXmLqUvFWHxeE4Bi
         6yJ26qURoSzJ4NjBY3WmVNlHrQPeml2zp8ER/fenRSY79BUJwiV5V4XTF2GTu/qVumzw
         QnGmkJ7EZPFNX1wOxDUM8AYKItvwaL0+H+jWy7lWojuXiae5nohG/fWU6j7aj987eoE/
         GZAA==
X-Forwarded-Encrypted: i=1; AJvYcCXIAwYkuqg6eX1L0VHsX1QqEtg1FhnXs+ZFZ7YymKcBS8aNqFP35cqe59RQBu8E+KnhoZZmp2Nn@vger.kernel.org
X-Gm-Message-State: AOJu0YwQN1OXdGQTlcHY6zcA3ZnKwalWi00gpr36wP8kVNzdBOa+7+Pr
	Ab5l5b9zyYVB9ejQCJ/PpGxZHsAtgLDV13q43FEwc2puQJz/NAZS9ya8PMaMWwlTCnR14yR1Tc7
	D/Hc2OqHAyFbPVJ1je29a2IPw39VRmYodMT/dwoG7uOZ+1EW+gpE1CNX89BE=
X-Gm-Gg: ASbGnctWGvAjE9e4628LpDgbd+wHwcmKSvLmdNsb4Y4/1trg8fjP0CbUMBJq8dsL7KS
	hhIieITFyeT8bETsaqbVpB2gU37l2jZw7j21XXQxt7vBGgPT9LEEFfaXZOWyelGzxDom7t86+eq
	XZ1WyBkePEXLC0r66xnRqqmA3CxtVkNz8f6Yfsc9pDEXNyDermSvTicI0tsNqkDdR3IAvypWF1H
	21G3d/TfnkajD1mB/0BF0rGd4j7pFdh1YHHwDizkWw8NZn7ew+/uJOrQeujFxE4+sYRbVTOkPos
	oR/tmED0aMggmi9UlEQn6iTb+vD4STuNwgY9oLWjwdAUKInplCXmzijqILBOqis=
X-Received: by 2002:a05:6a00:92a6:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-74af6e27ba7mr551927b3a.1.1750967632013;
        Thu, 26 Jun 2025 12:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIINjE/vY1h85MPe/c8z3TutZvYn7V+KXms08M+Thz7F1vzrvh5g64od1QB//BjvXYC4pBmA==
X-Received: by 2002:a05:6a00:92a6:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-74af6e27ba7mr551915b3a.1.1750967631656;
        Thu, 26 Jun 2025 12:53:51 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57e7279sm411582b3a.150.2025.06.26.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:53:51 -0700 (PDT)
Date: Fri, 27 Jun 2025 03:53:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: add repair fsck flag -f for ext4
Message-ID: <20250626195347.qo2sjqrtdj3cdigy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250625212022.35111-1-leah.rumancik@gmail.com>
 <20250626035125.GA198321@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626035125.GA198321@mit.edu>

On Wed, Jun 25, 2025 at 11:51:25PM -0400, Theodore Ts'o wrote:
> On Wed, Jun 25, 2025 at 02:20:22PM -0700, Leah Rumancik wrote:
> > There is a descrepancy between the fsck flags for ext4 during
> > filesystem repair and filesystem checking which causes occasional test
> > failures. In particular, _check_generic_filesystems uses -f for force
> > checking, but _repair_scratch_fs does not. In some tests, such as
> > generic/441, we sometimes exit fsck repair early with the filesystem
> > being deemed "clean" but then _check_generic_filesystems finds issues
> > during the forced full check. Bringing these flags in sync fixes the
> > flakes.
> > 
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 
> Looks good to me, although I might suggest ammending or just dropping
> the comment:
> 
> >  	# Let's hope fsck -y suffices...
> 
> ... since obviously, for ext[234] it wasn't sufficient.   :-)

Thanks Ted, I'll remove it when I merge this patch :)

Thanks,
Zorro

> 
>     	  	     	 	     	    - Ted
> 

