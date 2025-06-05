Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE3145355
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136116; cv=none; b=gjTme+n57y2kVB5BkxDkEdwoI2lIua911ve8XQB4itTqVMWNy2O5cHOdO7Q6+XEZWVy3n3es3IB3//lJg/ySRxJehjxb1tYaNlCNcBxTuGe3bC450fBOlN0UFdWetzIo7s4rDHOgKSwbkyjRECq28lxkTfmsTIqZsWxasqIaQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136116; c=relaxed/simple;
	bh=/FWFnu8CIu8cZgjTIn6xWJ39cQ+ZKszzMeLdB1JQTAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf94RG25lv6//n32dC7U8k3QB3YVDFKRERJzWAU2qeX3zGckWf/qIYjZIktg1FKXr+dKJ/8rLnMeOLLqBqwbfV9/1SSqej0dGx8ArOj9I3ti6hQ/Wg+UfTrw2STAIB10mzvbU66bT78lUcckcDj9DHYTVCRkcITfNhq1b5x8MRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JO8vI+Rq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JO8vI+Rq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749136113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YM2TuuU+K4pO8xMr3HsSp3m3Ax+cka6A7Yw+b/YyVMo=;
	b=JO8vI+Rqm6p28llG4kOlbBfKeWYux8XddLhjkCez00WpTS5cv6iLkVbgRrcUodpNQIGaDI
	Z2FnhUnGa2rTdA4gQfMOTMnBLl57/Qb/24rYFxn45DS+FkCa097a2H9eVmzBcZH+PHrB/O
	SzDgX8wrd1gODSE8yHMWn90oeYoxCCs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-l_1sGShSO-uUht0E39Zz0Q-1; Thu, 05 Jun 2025 11:08:32 -0400
X-MC-Unique: l_1sGShSO-uUht0E39Zz0Q-1
X-Mimecast-MFC-AGG-ID: l_1sGShSO-uUht0E39Zz0Q_1749136111
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2323bd7f873so9602275ad.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 08:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749136111; x=1749740911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM2TuuU+K4pO8xMr3HsSp3m3Ax+cka6A7Yw+b/YyVMo=;
        b=PJDVn3haICzKhg5I6ChNGSj5TOhmdD4WvWRO1xxQmOjd/+u302PUim6O0MNyVyINde
         iFMB8lYmm+fjMgO6UfiUTSTM0vNGlx2gURdxpuspFBDXJ8Pv2xAL+7xd/vffmtTzbF7v
         +UFjnKFb6uU+XQoFgkxo/8cP2lmBRuKtWx3sjgLYnaRLlgbybiTWjBTNtWR+s3VAcoLN
         8bV+E4dAtOjJhTGdE+xVMlY9d3EgpQkC/arnRJxsRNii3junUx+fkgbcyA7dETAKvlM1
         nekILnB/ZeZnHhf0I6FnpcL3rdlvkkNX6YtHO/Oip0f4iC90NlZC+SvM5zBLGrSJiV2Q
         eVVA==
X-Forwarded-Encrypted: i=1; AJvYcCVSMyNJ3tjEh2G72HnzHDHevCMtxF3Se7DJ3KXLMVsqF4uElgSqOGV7QiDy9Ed694HzCrf67oJe@vger.kernel.org
X-Gm-Message-State: AOJu0YxtkleYAJrP0mUw9C+mfc+ctCuMrt4+HNHOkiCj7vkH66G/YkDJ
	85Kp376sg+inmuyPJd1OOPwxbGc6xdhf9juyTre0VOlreoLsFGk1oXIqPhmRTckZ90ECEEzBUPX
	9WnhnZntofmJMrls2oCebVQbax/Vb3OsLL4KJFewu3cl/bc7CNHVtWBpfH8c=
X-Gm-Gg: ASbGncslJeGOs+VpjMXkX2+uHHWhDEI2q0g5t3OkzAHyu7wWIMGj0H3IBnq9JURn2cX
	ECFsmXQvkh/d09DDpsOjEjxmpMaiMQ35cyiixSJ4Tet8RYOiGmmWWGtafMGM6NlTPkLQNmvrYRY
	qROhq956WZVr3mwza9QxdESjpzbeySk+bx3MMJvIpp0HJkAXHXH920y+wcDa/wZRIbgzZJYrIb6
	CciKJHrR6PxKnHAfXBQlNDb4o/nnfRnFUF1mpeOmKSkiDNauhXkZ1rIx11CmxnR5T12ABXjv/8x
	sLorVQFC7xbPR1BmRt+IKu/WOwemuNPwgMULti0xdbED4aVa4sVz
X-Received: by 2002:a17:902:8603:b0:234:9497:69e3 with SMTP id d9443c01a7336-235e14bc6b3mr74909225ad.25.1749136111174;
        Thu, 05 Jun 2025 08:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcM4zuV+PSPXuMifbf7SpJX0aKuSsMei09R7aVHCp15nZubx27vBVv1TmQT1pheowASCslJg==
X-Received: by 2002:a17:902:8603:b0:234:9497:69e3 with SMTP id d9443c01a7336-235e14bc6b3mr74908995ad.25.1749136110878;
        Thu, 05 Jun 2025 08:08:30 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235e538eb4esm25812225ad.57.2025.06.05.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:08:30 -0700 (PDT)
Date: Thu, 5 Jun 2025 23:08:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Subject: Re: [PATCH v1 2/7] generic/656: add _require_chown
Message-ID: <20250605150826.il3nu3vmfrf7pqaa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-3-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091530.1218188-3-Yuezhang.Mo@sony.com>

On Wed, May 28, 2025 at 05:15:25PM +0800, Yuezhang Mo wrote:
> This test uses chown to set GID and UID, which requires chown
> support, so add _require_chown to check for chown support.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/656 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/656 b/tests/generic/656
> index cd49c4f6..2ff1c517 100755
> --- a/tests/generic/656
> +++ b/tests/generic/656
> @@ -17,6 +17,7 @@ _begin_fstest auto attr cap idmapped mount perms
>  
>  _require_idmapped_mounts
>  _require_test
> +_require_chown

Makes sense, I got below error too:
    +idmapped-mounts.c: 7277: setattr_fix_968219708108 - Operation not permitted - failure: chown_r
    +vfstest.c: 2418: run_test - Operation not permitted - failure: test that setattr works correctly

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _require_user fsgqa
>  _require_user fsgqa2
>  _require_group fsgqa
> -- 
> 2.25.1
> 
> 

