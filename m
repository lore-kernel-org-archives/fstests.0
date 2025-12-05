Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A071FF7C5
	for <fstests@vger.kernel.org>; Fri,  5 Dec 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956006; cv=none; b=UOw9HTsDIvH+6IIdAm081W6qg128ubGISoKe6G9vfpdx8icxp2Iu2pAAdl3NZbVbxvfFNZGb4tdJKdOGJc3SYX78492QkJx82or2C4P+4T/O1mZiLqfcdgJ0lZIqt8hXeLuh2/o60C1WA0kL6Iry1YECPJT3EgO5hGlKY53TigA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956006; c=relaxed/simple;
	bh=MXvU6wy8kiRw1rLT3BxJwWykSlf/19Z105D5vDBStVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4haN008T7Sc6/xZqDB528O2cCgAk7LDeUWPa9Et0hzU1xLnaFoaDr/3dLVdWb/ohvBKMc49xFaSux70OViyzK1oICXoGCre1kfcy67vpaCm/Fi+NiscXA2s9gwCQ7PHOMCewdD3TFnmmwctkqsI226YRDYb/AYzNBJ0ImoQhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RonqJtPZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEfP7rbQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RonqJtPZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEfP7rbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764956004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hXp+e5OOMkLppC6GEnYNdX5VZITKOpXjupoN3ddJOw=;
	b=RonqJtPZHCOcKQQo/4fG1xxTW3GNRiH8pY20L/WL68R5AlKlrendKE7uIQmUF8RwuFp2zk
	9P4RVZh42gEiQHpnQC99XEWVzRAE/9uoPuG3ELsktDBHnoTV7XHn/a35Z7hMjWM79fXlzn
	l9ycDRXygdXxQGcnOu/KHBII3v+FBnQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-Ye_nrlCQM-a8iaC3XhJi_w-1; Fri, 05 Dec 2025 12:33:23 -0500
X-MC-Unique: Ye_nrlCQM-a8iaC3XhJi_w-1
X-Mimecast-MFC-AGG-ID: Ye_nrlCQM-a8iaC3XhJi_w_1764956002
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297dde580c8so68526635ad.1
        for <fstests@vger.kernel.org>; Fri, 05 Dec 2025 09:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764956001; x=1765560801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hXp+e5OOMkLppC6GEnYNdX5VZITKOpXjupoN3ddJOw=;
        b=WEfP7rbQ/yeA9h0fZBMhEthvq5hSA8vqMdUPQccvpe0mZf/iU9+/ud9Bm+HLWSeCBn
         pRRImujW3/K67ZefMYljPmsh7EnEP6uYIaLvHr/skTLinZh1Sp5W6OP6YCgr37wcyoC6
         3tuf/rV6vZ56FR3opwks+8WIg9W62njTLf57jeoMNpxBJvW/LU7Kp1J0vyt4vnILNj5Q
         FLDddYb7/yF48MGlA/l3yfOWOW880WmMxaZmGpZbPNagGE+DANr6yRhvPMwWAgfNZNDF
         Mvvo38f+BLxQC4JGi07huUy0RJ0QAyTHCTQ0ZPh1T1+RvXolZgB2AqjObVAGvU75LIX5
         nHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764956001; x=1765560801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hXp+e5OOMkLppC6GEnYNdX5VZITKOpXjupoN3ddJOw=;
        b=mEkd3t5W4wTgl4I1Wkd1FeOg8BwseeABVBjhqGdgO7neQeSjtwk/9aLWHb9VKE6IBS
         NrG294SrLK/PYYeThBg2jIBA6Yq1J8tL2u3eeLu1ZOAdhk5b1jnpMZayLN5kWhHGkiO6
         cvrycAwNs1Q4RuOhbF4z5px7/lRojTbuCvH9dq2EcKcTTg3NrY82CWNBSDmlIzHsasKQ
         80rtuOFtSO+wvSSdtxr6wQHh0FSUPMWWcgfg35PSi4NyK0a8IR8E3siJvdqh7KJpY96L
         H0g6hcyw/RSdDzxd5ESi22MQzbQf2H7f9hFPo+gp1dwWFtHkEAHRgURHEyRTgrhBYPsf
         nGVA==
X-Forwarded-Encrypted: i=1; AJvYcCXnLil9PzNNxvjuGc4mcz5tqI9WTrx0D8mDBa5TCDSWyLO1CPsy98Bg1rSdu965pLDojdZ24/8t@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SPmTWHLApL1XwI7YnyQIFDzPxSPWTja/bSxPdRd4L+GX9Grg
	Ri1/Q9YYEW3Vvg+HCAc87nM9plsS7X0+qYKPq0DMa8v7o8Tuv6BoPzjDr2p7iuBgZQTp86kgzCh
	+R5B3MnybAPFtQsbJlrUoYddCBNtNk4g1B3Lal4KEkbaii51oiZISjLqd5oJ1bulbrpo=
X-Gm-Gg: ASbGncstKOLDS2AeEYtaJ3LkeYjP9eLUqK+kQ1lGBDa2kdEVNkHgLuWog9GskiJJkJR
	HjB2g0xczE7Ya/xrUpfM9iCZHBgfpHA0nBJhsg/n4BB51S1j5bmz+q9atPUGeSHeEAzDTCxFr0S
	K3olysFeHz88Xea1gD8Y+mW3XocOeOYX0VWRkqy6UksJsPNjV+LDieS4tb0/VIAhXjZdjWQCsaN
	uOnD15wq6c7fk4vREr+mx8jxHuHn9XmBWE0QkO4ogyMjTopIeyc7fCp1+7dLYptD7ytcLnlVNcl
	P300Q3hCZjRj58uEIwkQOfVc+4E588FZvRGnfrNZxW/a7Hr/IzGOO5WWxX7hN5ZoWyOAbw2N79J
	4Lk2EfjCJWWUlbKYSrMYymKeiMPD0iminO8nWwmNn9CnltXe94w==
X-Received: by 2002:a17:902:ebc4:b0:26d:d860:3dae with SMTP id d9443c01a7336-29d9f67d6ffmr90274615ad.3.1764956001401;
        Fri, 05 Dec 2025 09:33:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXSAcxY7YjQ2lRI1nGPuunb+yTEFSA4OqkCp4H3r1VZMT2FFkora3jNK6GzgmAw9mg23K+8A==
X-Received: by 2002:a17:902:ebc4:b0:26d:d860:3dae with SMTP id d9443c01a7336-29d9f67d6ffmr90274365ad.3.1764956000922;
        Fri, 05 Dec 2025 09:33:20 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabfdcsm54033305ad.75.2025.12.05.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:33:20 -0800 (PST)
Date: Sat, 6 Dec 2025 01:33:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/158: _notrun when the file system can't be
 created
Message-ID: <20251205173315.y44ddyjknco4ji3z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251121071013.93927-1-hch@lst.de>
 <20251121071013.93927-4-hch@lst.de>
 <20251205073125.tddypzbg7lyrzwna@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20251205080811.GA21212@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205080811.GA21212@lst.de>

On Fri, Dec 05, 2025 at 09:08:11AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 05, 2025 at 03:31:25PM +0800, Zorro Lang wrote:
> > > +_scratch_mkfs -m crc=1,inobtcount=0 || \
> > > +	_notrun "invalid feature combination" >> $seqres.full
> > 
> > Hi Christoph,
> > 
> > BTW, shouldn't we do ">> $seqres.full" behind the _scratch_mkfs, why does that
> > for _notrun?
> > 
> > Two patches of this patchset have been acked. As this patchset is a random fix,
> > so I'd like to merge those 2 "acked" patches at first, then you can re-send
> > the 3rd patch with other patches later. Is that good to you?
> 
> Please drop it.  I have some ideas to attack the whole set of issues with
> combining flags in a more systematic way, but I'll need some time to try
> and test them.

OK, thanks Christoph, I'll merge other 2 patches in next fstests release.

> 

