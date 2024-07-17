Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17881181B8D
	for <fstests@vger.kernel.org>; Wed, 17 Jul 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229713; cv=none; b=UpuUMKRw/PlaoZeixd7u2xQ9vj0lNkUU5v5dydhZSGjgMorzEOWXDD0mP5FkFrx/RuwYDIY1VdVCiS7qsi5EwoQ5c5WfFBO/1HzJwr3/7FaW5ROAjVBkh63nrGFKoxVFpghnQ5KYJ1nPJiSiFqIx3wy3ieatiZgfjXtEmWIWyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229713; c=relaxed/simple;
	bh=gV8vBL1c9bYkNKacBpFknaPkaVfQN4gsmXp5zyBDj/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNXFou1WJ5P53WpAe6phTjIVm2XZ5iJXu/kcrV8Y5Lf6+z3aMt+clRGskPrCV2GP8ajUvjdxV7rrwil/TP6XMfTbDH/VjJ9zM5B9WL5rUDGfMoSALf4R84KFwFe4o8OWO5q1jovgA/XcTN4h8J9F0QiZgknTzY/zZcuKP2j+EFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDwW53Qb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDwW53Qb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721229710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iMKfnGWJQrqlZ4fKl1+DjEcsKK+hF0UigdkecxagA4=;
	b=MDwW53QbGsze0lGD7IkBe4BkxNCKK/kQdX2dSXrDd0c3Hqjuio6tkeFfuzo7ThaA8piRk+
	JfTuzEvna/YG6qyWvU56NunUsQ3kgLVJFVpG4ijWzW0dg8M2oXtvxQUJZ1si/RWrabb59n
	wDlE9ITXhdBbjj8RynLS0HnOlm+xSTE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568--A5K5sMrN0OBxHAmc4--hw-1; Wed, 17 Jul 2024 11:21:49 -0400
X-MC-Unique: -A5K5sMrN0OBxHAmc4--hw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fb269ff96bso42346155ad.1
        for <fstests@vger.kernel.org>; Wed, 17 Jul 2024 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721229708; x=1721834508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iMKfnGWJQrqlZ4fKl1+DjEcsKK+hF0UigdkecxagA4=;
        b=ARxE4PdLqDX1JIGN5G2kIIEbydWOaAsKuWm77GukXnadsKFK03CngXsmcRHzqfey2+
         jbH8i7IAzLJafZt1vMwc9CRRM2gtWPWDXm0y/TEu1+MWGLfXuIcfqOGGh8schV5uTNoi
         ZwKwgwDNvtfbIhybswAugNK8uov1ktqoL1Cf4Zr9b5xgvyIoM1W4KJswU71VFHwuTf33
         xwsRH7LAdm4qD1eJqtI7LOW/GQ/sX2y3xzcCbpvVhN/oAdxwLL9r7bXjNbyYSufXj6ZK
         lhn8u/8kaiIIEJuMunKPzEbPRxoNmjSfuPw67Vxs0iRcFLp3Q0BoM8Tg+JyUs2BphkxY
         XF/g==
X-Forwarded-Encrypted: i=1; AJvYcCXjYJyBwdL/sIShejRzK/HFOwDyguzLk8Z1Cf6/tzqBYWjx0oYunIWSKzM4l3lMvaRVMRQETQl0M082WhwaAjLn1kJaU8yoRg==
X-Gm-Message-State: AOJu0YwqdR2X3STuYpsDlLIwet6WzGU5sD214KVU8SXym3F0c6YLN2/a
	Z6PR1zYFmV2aryhYeNObywJ1/efjgeKZP+vZszWuhAx78jJvHX902yU6XbpqIQpJ3tbEhdFsrzQ
	jQQiCJYDwovTkoG1tm07DPHmSzwhGM0At8iEzsP8LPYt3nsmoe3+/pJs=
X-Received: by 2002:a17:902:ea10:b0:1fb:5c1:2681 with SMTP id d9443c01a7336-1fc4e13f270mr18161435ad.21.1721229708324;
        Wed, 17 Jul 2024 08:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOfDY24x5qcTWp45WDUUdC0sp6SCvabQm/v3y/wfUXYj16XlMX79llmXI5Zp1EFF2HhJaapQ==
X-Received: by 2002:a17:902:ea10:b0:1fb:5c1:2681 with SMTP id d9443c01a7336-1fc4e13f270mr18161305ad.21.1721229707988;
        Wed, 17 Jul 2024 08:21:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb70060sm78257905ad.58.2024.07.17.08.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:21:47 -0700 (PDT)
Date: Wed, 17 Jul 2024 23:21:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.07.14
Message-ID: <20240717152144.ieynbbdohmb7f2yw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <64ec6187145dfd111f22f1ae151ae538@kernel.org>
 <20240715154454.GB70013@mit.edu>
 <20240715195026.5c4qvx2thoeessqu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240716201347.GA2166460@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716201347.GA2166460@mit.edu>

On Tue, Jul 16, 2024 at 04:13:47PM -0400, Theodore Ts'o wrote:
> On Tue, Jul 16, 2024 at 03:50:26AM +0800, Zorro Lang wrote:
> > 
> > Sorry about this trouble to you. Sure, this's a behavioural change, and it's
> > been talked several times. Generally, even with this change, fstests only run
> > tests/generic and tests/$FSTYP cases by default. So it won't run tests/btrfs
> > cases if FSTYP=ext4. But with this change a fs has chance to force to try
> > another fs' case by specify the case name particularly (if the tester thinks
> > it's good to him).
> 
> Yeah, it's not a big deal, and I saw the discusion, and I didn't
> realize that it would cause the regression test failure for my test
> runner.  It was relatively easy for my to work around it, but I
> thought it would be useful mention it in case it would take anyone
> else by surprise.

Sure, you're right, thanks for this reminder!

> 
> 					- Ted
> 

