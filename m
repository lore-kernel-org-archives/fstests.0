Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F27204685
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096115; cv=none; b=cH7M3kWPIylpqh1UcLN3tTEYF2TcVabGlj+EUrX+lbEGwQttdhWEk+URDOEWiZFyOKfOdNVanITjUrWH2DkrJF7SqzNk/p0/bwXLHdLxdt3QR0WUt5+yqhMyTnu3dc1PI1up6WKzC5mwrSNlh2pkgnWWndPD+nXjgwMegpvKTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096115; c=relaxed/simple;
	bh=fBZvV9bRWUHgjBBblH8ILhh431CcWFIKwME30n8IBc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXcN+iXfIdZEl2uNr/ja3rZA4b9E10PEs1lsjANMcKi4Mcxm4yvCP/qpllpkhQqvUj174bCUahW6OhgrQ0us97ua+PaE6Uw/+giDrfjZAWO6kSytcYumBLE9buxE6pIRMRFtFc3PnnMHxooAQl9bWYiTCfMXIcgjCA04X5TAvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5moAecE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5moAecE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741096112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k/56JRy0h+LOamsJK6EHUk+EURm7+5YTRuLjJXaIofw=;
	b=S5moAecE8s5m6vWglw407K0ht/XKnVjjpLAS/m7rWtq3t2L9y6tuyZtsaQEL87roRd0svX
	dbBiBgi7Vd0e7mj/WV3US9O3VUfK+Jx9qesxguJOTLG/9IRrIf+dh45CXLkoNOI89RdLyx
	4WghEOgDWIeVMaHPDkvPCBfhxtMODn4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-xVBKK4AyNYyw4kj9-iLFeg-1; Tue, 04 Mar 2025 08:48:26 -0500
X-MC-Unique: xVBKK4AyNYyw4kj9-iLFeg-1
X-Mimecast-MFC-AGG-ID: xVBKK4AyNYyw4kj9-iLFeg_1741096105
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2234bf13b47so108257565ad.0
        for <fstests@vger.kernel.org>; Tue, 04 Mar 2025 05:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096105; x=1741700905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/56JRy0h+LOamsJK6EHUk+EURm7+5YTRuLjJXaIofw=;
        b=ZA1vK/qN5/J5okz7Fnt+ATVGtv3Lfj5O05iwWgzqEy0y4+x1xNVUMvq8GS8WYVytjf
         4olj7KCSmMcQTexaOE0U4gITNP98oBifXe62KW1/5vzRufsP2hZd1qvCztr/xTIoxPOF
         WD4b2qx1LsC9qizhtm9tytzZdrxiW5UA1t4GB1D4n7Lof5/yuBounsYmvxgssBMG3buD
         CFS0jW7u6syrpbp5TB7HiQW2Wr7G1DdWHKclf0R9/I3cDsK7CQt/CTa3d+/Dbv5+Lh/b
         ASKqGkq3kUGz48t6PllIiw7Yici9SZvLaJndET+XeVZhzRXdoRimBCVq/NNLi0IeeStI
         zJrA==
X-Gm-Message-State: AOJu0Yz6amtMiM1GzO85Mmn/CYVTq6aMHPTxLjZDpYpI6II2qwve4NTZ
	TX68hoWyBzI0dvA1AhDc0378RD2KL6YwJwqg7xMO/fUsZM6PVEd4zdTHJbxfzUk6v0x20EmoOhL
	1TxtGLwhFnzBkeSn/iTc6F8Q0fBailH6aXMfSbw8B68OgB1rWWwMRXi7KKXVDsCDQRw==
X-Gm-Gg: ASbGncvpdFKajVRwwEOyeylSKsQogIqArfeSAvPWFdEmEDN7hBV3u8W7O0dXGkzBOXk
	y5Z6tP5GYqK/mKjc8I3c4XbpK/BA+Uy/EVxE9CMEaLQSnjYgTTnVqifBMX6nea0MDIyIDOB+0dY
	fvbRxkt5pjnLoIXtIhlxMdqHxi3yGvz7QDrZkGEMkxfkEpeeGjm3JxJxVQ+6ErwRX40ERnAMmsP
	SQlCohccs1DeV06KrH23pCQ+a1rGXc4qTfKK+RfQ85KyS/ow5qzhE2IUv6uMpw6N2QStZvua668
	mUMmxynAbtAHxsY20QFtPqBbkN1tc8ClXZKvTo6bEzZBcpnQteJzWuye
X-Received: by 2002:a17:902:d2cb:b0:220:f5d7:6405 with SMTP id d9443c01a7336-22368f7b5e2mr298841075ad.16.1741096105070;
        Tue, 04 Mar 2025 05:48:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0HHpEFMKJcHtM7o7xFdAQNeZNq9a0hR/KY/PoEgR8ABBPvwvWSIQUCABt+aShxfs0dKrlrA==
X-Received: by 2002:a17:902:d2cb:b0:220:f5d7:6405 with SMTP id d9443c01a7336-22368f7b5e2mr298840735ad.16.1741096104639;
        Tue, 04 Mar 2025 05:48:24 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2839sm95254685ad.39.2025.03.04.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:48:24 -0800 (PST)
Date: Tue, 4 Mar 2025 21:48:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Henriques <luis@igalia.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] src/locktest: add missing struct cast with syscall
 getsockname()
Message-ID: <20250304134821.f4iwcbzx46khrt5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250304122119.21412-1-luis@igalia.com>
 <20250304122119.21412-3-luis@igalia.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304122119.21412-3-luis@igalia.com>

On Tue, Mar 04, 2025 at 12:21:19PM +0000, Luis Henriques wrote:
> The usage of variable 'myAddr' (struct sockaddr_in) is being casted into a
> 'struct sockaddr' when used with bind() and with connect().  This patch
> adds that cast when used with getsockname() as well, otherwise we'll get the
> following error:
> 
> locktest.c: In function 'main':
> locktest.c:1155:39: error: passing argument 2 of 'getsockname' from incompatible pointer type [-Wincompatible-pointer-types]
>  1155 |                 if (getsockname(s_fd, &myAddr, &addr_len)) {
>       |                                       ^~~~~~~
>       |                                       |
>       |                                       struct sockaddr_in *
> In file included from /usr/include/fortify/sys/socket.h:23,
>                  from locktest.c:19:
> /usr/include/sys/socket.h:391:23: note: expected 'struct sockaddr * restrict' but argument is of type 'struct sockaddr_in *'
>   391 | int getsockname (int, struct sockaddr *__restrict, socklen_t *__restrict);
>       |                       ^
> 
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---

From the manual of getsockname:

       int getsockname(int sockfd, struct sockaddr *restrict addr,
                       socklen_t *restrict addrlen);

looks like the 2nd argument is "struct sockaddr *" in GNU libc too.
So I think this patch is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/locktest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/locktest.c b/src/locktest.c
> index 0e7c3008d1d0..a6cf3b1d5a99 100644
> --- a/src/locktest.c
> +++ b/src/locktest.c
> @@ -1152,7 +1152,7 @@ main(int argc, char *argv[])
>  	if (port == 0) {
>  	        socklen_t addr_len = sizeof(myAddr);
>  
> -		if (getsockname(s_fd, &myAddr, &addr_len)) {
> +		if (getsockname(s_fd, (struct sockaddr *)&myAddr, &addr_len)) {
>  		    perror("getsockname");
>  		    exit(1);
>  		}
> 

