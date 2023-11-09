Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E9110E
	for <fstests@vger.kernel.org>; Thu,  9 Nov 2023 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGy0oC8h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3757269F
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 17:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699494645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wO9s3m87KdAOj8dUM4yEg5modSpx8d1MOGCkijjqOoI=;
	b=IGy0oC8hd5ZG5/W8vbDSS6sBQHcSwL6QyHEirxKtJv5SvvIyNz7PzL49XTiUIFIjaGUb9R
	sJ1DVV2jAb/PnCshAXuhK/J5zjyWtPZumoPz3JiCfKRl2EiDYLsWxdMwwT+xEpssh7mgam
	H2EIZJRQy58sPzb+dEkU/oL2/ZEt8EM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-ga4qo51XPAi-_7J-LBufUQ-1; Wed, 08 Nov 2023 20:50:43 -0500
X-MC-Unique: ga4qo51XPAi-_7J-LBufUQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6ce26d7fd45so298109a34.3
        for <fstests@vger.kernel.org>; Wed, 08 Nov 2023 17:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699494643; x=1700099443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wO9s3m87KdAOj8dUM4yEg5modSpx8d1MOGCkijjqOoI=;
        b=U6m8Qc+0vnVsr5zWU0xsHiTWk3sVUMZwzhAqimrG9rm2gUFA6CF5m+kXTl5RrqU0/l
         zTRBA3n/43fBT4gZ76k+6v4whcjdRQBes2UlXFvPtNSqEGf//ojTjkpIyRXuvFFHD13v
         Q9SpavJMiHosxGU2i3BNxyx9E0gB88Q6HGUecAOj/V7eCKmBO4G6/W6EldrY/5eBmTt2
         66vtEO/5z86cvr8aRMQeqnBlIpdKuNUZeWqrQWnfxYP5jIV3W4dQ4QxuGG+wdb78CtUD
         c8JaDEZL4Gt1VNYSA+P53OlMKO6GI4qvAqGO97DUPAbdmyGZKRHzgc2NHWcHe4Vgw/4f
         AMFQ==
X-Gm-Message-State: AOJu0YxUnqAC6OoTWxzTGFxVc+LBDMrUNOeEuM/o/Bhu9xFoKY/U6cMB
	wIPUbf9F0bu5k0vnIHZ3iB55n+xZwkM1oKLlMDPMm6VQG2Mlr3S6PUBoGmgQmceqndn0fVTsf0E
	zOkPcCT4Yx8Xi+cpt3w==
X-Received: by 2002:a05:6830:1bf4:b0:6c0:9e24:6eab with SMTP id k20-20020a0568301bf400b006c09e246eabmr3975593otb.33.1699494643287;
        Wed, 08 Nov 2023 17:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCEBDzcomi0jpbp8LbNnvxysJq0VKVbEHXKgZ9s3wB7Jgl4wxvistJT9ufWfgI0rmiF0Q3AA==
X-Received: by 2002:a05:6830:1bf4:b0:6c0:9e24:6eab with SMTP id k20-20020a0568301bf400b006c09e246eabmr3975583otb.33.1699494643074;
        Wed, 08 Nov 2023 17:50:43 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b0068fe5a5a566sm9827612pfm.142.2023.11.08.17.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 17:50:42 -0800 (PST)
Date: Thu, 9 Nov 2023 09:50:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: edward6@linux.ibm.com
Cc: fstests@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [Bug report] More xfs courruption issue found on s390x
Message-ID: <20231109015038.nyhlsmkzhq7eio7d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231029043333.v6wkqsorxdk2dbch@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20231108163812.1440930-1-edward6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108163812.1440930-1-edward6@linux.ibm.com>

On Wed, Nov 08, 2023 at 05:38:12PM +0100, edward6@linux.ibm.com wrote:
> From: Eduard Shishkin <edward6@linux.ibm.com>
> 
> On Sun, Oct 29, 2023 at 12:33:33PM +0800, Zorro Lang wrote:
> 
> [...]
> 
> > All these falures are on s390x only... and more xfs corruption
> > failure by running fstests on s390x. I don't know if it's a s390x
> > issue or a xfs issue on big endian machine (s390x), so cc s390x
> > list.
> 
> Dear all,
> 
> It is a really great nuisance. We are looking into this from our
> (s390x) side in turn. Unfortunately, I don't see any ways except code
> review for now. If you have any ideas on how to optimize the process,
> please, let us know. Right now, I think, we can help with additional
> hardware resources.

Thanks the reply from s390x side, we had more discussion under another mail
thread:

https://lore.kernel.org/linux-xfs/20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m0888b2314d0dc866bdd7e1bd8927e599d57319bd

This's an issue about a xfs feature, but only reproducible on s390x. The
expert from xfs side is looking into it, I'll provide more information
for debuging. I'll cc s390 list later, if you'd like to watch it:)

Thanks,
Zorro

> 
> Thanks,
> Eduard.
> 

