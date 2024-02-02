Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370413DBA0
	for <fstests@vger.kernel.org>; Fri,  2 Feb 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871422; cv=none; b=MYSyF9e/ytrpb0qbW4xLSri2UdHhDtCFlnzKbMbJgzofCUNExDIbR2S9GD31e6l9ZPJgh5OMgH5u08og73c7Z4LSZF2FW+6RGBXz94TElp7zeGrecx29kpxrtb2E8lgg60I1EP6MshRUJBZ9wn5nZ8HsV/aXgcLqv8P3YSzk1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871422; c=relaxed/simple;
	bh=tPZx/nmM3MWUWcxcAWlnmyHLZDWq5GY2HtisZ3Jm13E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byeExffM8QJLWp0EQ8nyiW+4zLmgSiFlOFquvKS/YOz0bXPnG9p75CIpa+SQ29VyXezcpMW/Y7XqQJb3+jgJyrWu4YW3/+oceXfHTORheg0adaMu8CZAWG7Rl9bXmIusaMAOjXZ+2GdwPPfLk8SnPr+Q/JHboSk2do3UmVh/6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bd0AyLTz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd0AyLTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706871419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sTRmklHraUtWLDdU2myofLcUMY+Af49oeoki8qD2f8=;
	b=bd0AyLTzwBCFiuvaaNJql6rDdku4is020MX0yXzGB0jiMpUHLA2TuWBNyaXAm5KnIZdKcz
	Y0hoLDKHH3VqYumBa6SulUjnJSr17xh2skrKkCgx+JUe/YujNyJHXOrZxVoXwwCQrO9Pxa
	riEz6Zt8eyT9xOpPCYZcbN+9FjndphQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-NaL3sANgMmCqjMHYUlMXWA-1; Fri, 02 Feb 2024 05:56:58 -0500
X-MC-Unique: NaL3sANgMmCqjMHYUlMXWA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2fba67ec20so136943766b.3
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2024 02:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871417; x=1707476217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sTRmklHraUtWLDdU2myofLcUMY+Af49oeoki8qD2f8=;
        b=LuCxWHKEgy1ZM+PxtfjYDbuqWOY/oQMv8YVciUPDBcBqcULgoY7Ft/bKQDJqp66TEI
         fZDuphQ19fHBQzxPQjh8ZzQ06/FhCkpP611IMgwM80Twz+eGpR8p1QyMh2EgxZaNBGgt
         2eygrX+Wc+LAdIs9V0OL9Svgmh+3X8Lh1D9o1yADd5zg3gVxaXz0zd033KfMBuuVrC2G
         PzbWtSq6mRONwuIYtkDAz97kxMVTIxmyjGbwxfbjT9xpPjLSxZ6M2opgvs9wYcBBOOHd
         y+jH8zwt5TTuuDxKUoN9HLoAI+Xw3w5EyIlL/OCQzNv+Tyw3X4rvLmFTZpI1RuTWNs68
         Sa8g==
X-Gm-Message-State: AOJu0Yx4EL9d8w4CcTbpVEZ9SYRq5/FzR9oxGH/RK6Py3nEREuU1HeTT
	tzWt/8B5mzi5qDypl24Vd8tfQFU9wuA1sglKlQ6ENp3lNMCbsZCNqMVwIneoI/Jk6XwjMnIXAzA
	fwEbP12r3+QhL22zkHNpyYiEL3AZhaRMM49F9JS72L0cl6g90Wr9NC6M8g7DC1Q==
X-Received: by 2002:a17:906:48c7:b0:a35:62a9:a659 with SMTP id d7-20020a17090648c700b00a3562a9a659mr4797155ejt.72.1706871416905;
        Fri, 02 Feb 2024 02:56:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5rUru5u69EkorpvAYQGRMPITnkSgI0u0BZhQj621h82lgQXwt1/vQWwkiTu81jIQM/mZ6pw==
X-Received: by 2002:a17:906:48c7:b0:a35:62a9:a659 with SMTP id d7-20020a17090648c700b00a3562a9a659mr4797148ejt.72.1706871416516;
        Fri, 02 Feb 2024 02:56:56 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id sd25-20020a170906ce3900b00a359558648esm768595ejb.24.2024.02.02.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:56:56 -0800 (PST)
Date: Fri, 2 Feb 2024 11:56:55 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic/68[12]: use the dir blocksize for xfs
 filesystems
Message-ID: <l562muar7hq7vldj5wngowdfwpsqyrgytlilsc66v44k7iki3b@q2s43fymypp5>
References: <20240201161732.6126-1-ailiop@suse.com>
 <20240201161732.6126-2-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161732.6126-2-ailiop@suse.com>

On 2024-02-01 17:17:31, Anthony Iliopoulos wrote:
> The tests are using the filesystem block size for calculating the number
> of dirents required to fill a 2-block directory. For v4 xfs filesystems
> formatted with fs blocksize of 512 bytes this is failing, as the tests
> do not take into account that the directory block size is not always
> equal to the filesystem block size. As such, the tests never go over
> quota, and even if they did there is no hard block limit being set (due
> to 512 / 1024 = 0 calculation in setquota).
> 
> Use the directory blocksize instead of the filesystem blocksize, when
> the fstype under test is xfs.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---

LGTM
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

