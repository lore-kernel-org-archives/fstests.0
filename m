Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F836D1A3
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7VWVK95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705066804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eR00AhH+shlrnUBx0ovB0jfbN1lij8ctFTdOSWKfP3g=;
	b=f7VWVK956gOdX8poN8P2Z6Xr3V5FRmBt9FxWup7ssciVJLbhIHD1BxnP78s/TfUaZynvls
	SpK+9OA1JT9sQ5oKOrQTcF6v/9j3m18pNe8/9hRTAhEz5tbBF588NCNGKmtXiF2nJluI6C
	hiv0WMcwtZlxS1jBjnlYny9e1AYCQ4g=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-Cni5znL7N4KMvhM1tJF2XA-1; Fri, 12 Jan 2024 08:40:03 -0500
X-MC-Unique: Cni5znL7N4KMvhM1tJF2XA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-598b8d4c64aso1515115eaf.3
        for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 05:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705066802; x=1705671602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR00AhH+shlrnUBx0ovB0jfbN1lij8ctFTdOSWKfP3g=;
        b=PWxmk6mcfvJ9crivHI+/I2mGVBF2/uoEaFamHH/leNZ9DM+5wR2KtjsjLlJ28HKkfe
         1QO8qr5EvoxVkcxRNZeVn9hViQF2hqrc0RvzyZO83WR03XC8shWYflHNNxQF2xr5v77c
         hgxUDQwJ9V0O0Lx+PfVTeuitTvEwMq9SKlgs/81VdNLTL26pS+Va1Z+l/OyidPM5KSzg
         aTJOyTx4cFJNND+EtrA3Ob8ZYLjSegkdA4w+OiMu4GbfQCsUsGsP7ebrztUYvl8cxbX7
         d11zOkeirvqwDVQXDkiDwx0g0+eByoieoz5ubg84+Akx/m2JKo5YKfoCt4W03ee8cNHx
         2TQg==
X-Gm-Message-State: AOJu0YxydIG5BLBsXkgo5rAtD9GVlO2qq2hSrt3WBMdM8RMv28zGukvA
	k+VysfK9Wpt4nvBDb0tgZm80suKNg8OS9xfzLPAIqHLZdooYSCY63eVmU+Dxn1nBehc9uWi/F8N
	7d7FRiWocRHV18yR83aEj9QlUAA==
X-Received: by 2002:a05:6358:c3a3:b0:175:960c:17c7 with SMTP id fl35-20020a056358c3a300b00175960c17c7mr1076961rwb.14.1705066802555;
        Fri, 12 Jan 2024 05:40:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjTs44cWJcLcvET0ZZbx8OE1urr2qihH9EWh/Ho3cygsX8/+2sPzpweq4nclludGIUCKaQqg==
X-Received: by 2002:a05:6358:c3a3:b0:175:960c:17c7 with SMTP id fl35-20020a056358c3a300b00175960c17c7mr1076952rwb.14.1705066802231;
        Fri, 12 Jan 2024 05:40:02 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7804b000000b006db313c0db8sm3270855pfm.92.2024.01.12.05.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 05:40:01 -0800 (PST)
Date: Fri, 12 Jan 2024 21:39:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Daniel Rosenberg <drosen@google.com>
Subject: Re: [PATCH v2 0/4] xfstests: test custom crypto data unit size
Message-ID: <20240112133958.pgxs3gl33g5hf7pn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231121223909.4617-1-ebiggers@kernel.org>
 <20240111035444.GA3453@sol.localdomain>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111035444.GA3453@sol.localdomain>

On Wed, Jan 10, 2024 at 07:54:44PM -0800, Eric Biggers wrote:
> On Tue, Nov 21, 2023 at 02:39:05PM -0800, Eric Biggers wrote:
> > This series adds a test that verifies the on-disk format of encrypted
> > files that use a crypto data unit size that differs from the filesystem
> > block size.  This tests the functionality that was introduced in Linux
> > 6.7 by kernel commit 5b1188847180 ("fscrypt: support crypto data unit
> > size less than filesystem block size").
> 
> Hi Zorro, can you consider applying this series?  It's been out for review for
> 3 months, so I don't think reviews are going to come in.  The prerequisite
> xfsprogs patch is already present on the for-next branch of xfsprogs.

Sure Eric, I thought about this patchset last week, I saw that xfsprogs
patchset has been merge. I'll give this patchset a basic test, to make
sure it won't break xfstests, then merge it.

Thanks, and sorry this late.
Zorro

> 
> Thanks!
> 
> - Eric
> 

