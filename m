Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A531CD01
	for <fstests@vger.kernel.org>; Tue, 16 Jan 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425065; cv=none; b=n8uKNtweMdYe/j1ghMbw4t/jRvnIP0c0gg4gldHw5LF0VdqO84OtAaLiF3yuQ+E06+cJyFnSH5fK9IsWmID9ltKTtrpz/YP4NYx05jd9UtL/42s63F3HD/fY53fqVB/1EnLzcYQ0SngEJgrO+kIoIwB8sa52KcXRSmVVr2WO1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425065; c=relaxed/simple;
	bh=aE0wFqGG+kUfWXofLdxcGx70Ox1AKA2ZmvZjjfJJPd4=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=VfgVXy15hwZmwta0teV6gFfOwM04xmouSA7nQDazW4Vj5H6u01h7m4Req0C/jJdFw6BVH70ZGOY1yTkDR76nUIjNH2Gwoolwh2plZpK6f8IA/kOH2wrr2F+9bYrwTfMV7oMAiE99JZfnUbYQiS1M2BTYJQZW5xb0fttGuwp2+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRIKOKw6
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRIKOKw6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705425061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZZ0q0p3NmlH2EMi8Rk/xDdZtVzc1oDldCK2jlSN9V8=;
	b=hRIKOKw6+SCD1YRejC0lJvWYJxw8x6eA07xfrihlhaxFc2Id5fT3wGuUwkFq/c9/biXRen
	Pj7F0neEUJhBBp7hNOo4fFj1Si7OSCbeqTA1iD6lBfXNlaut8iWQrZAA6/GhrS9jqIGfj2
	8vuX2sYr5PXUHTR+aSmIbiq92iWUsE8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-l6g49TvfOGyyO80l8EZimg-1; Tue, 16 Jan 2024 12:11:00 -0500
X-MC-Unique: l6g49TvfOGyyO80l8EZimg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6da0d1d6674so11794445b3a.1
        for <fstests@vger.kernel.org>; Tue, 16 Jan 2024 09:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705425059; x=1706029859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZZ0q0p3NmlH2EMi8Rk/xDdZtVzc1oDldCK2jlSN9V8=;
        b=P0nMh6g5i9QxaIm5E2iW2tlzw7dPi41CISC259tRg5guIBVx8i9i3hGUcj3BWXtHj0
         M8brhFXMHFsPjCBSJImePXuEsTCS3vgHHfA789Qb3b3jhghPQz8d8n3Pa4zAUAoqIhTh
         44vMXU5t8g0vGwai9DCXNbkAXFIWrx+KgJeovFwxNdNoG9mw4UUMz4Ei06LEuUCxNGA0
         vvtf3TnW9xMlJAEk4ZvG+N2i4gCmC0UWR9oolUrbZNsmOnQjHWiGL7VYeFJ/9bCdXYlu
         d7qr32SShmTNqt2mkiC4HSM+h+lW0KaVg+9osaFUCJuVa9TRCVVEG7knIgXcQwHv+LHz
         vQ1A==
X-Gm-Message-State: AOJu0YyMLSpOjqrvVZ167m0Qef5Cdw2wN7NLHt0IaMpg64J8Nq0betfY
	wPPuw4nev4H7+uSsqbiIKQA/sKZOgbvsVM5JGer3Z2DPNwMyFZvyYXgIhaMoFQ8OqLIQbt+FrAQ
	pL5aAQeZbkQAHFET7TU8EbTMUHQ==
X-Received: by 2002:a05:6a00:398b:b0:6db:79f6:777b with SMTP id fi11-20020a056a00398b00b006db79f6777bmr4988007pfb.33.1705425059025;
        Tue, 16 Jan 2024 09:10:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnRnij+eXeH+EGwPa7QDrwUlgE9sZWP1WQA7uAoMv7sO03sOTXpwHBxxCTbpozV84yxej+UQ==
X-Received: by 2002:a05:6a00:398b:b0:6db:79f6:777b with SMTP id fi11-20020a056a00398b00b006db79f6777bmr4987998pfb.33.1705425058703;
        Tue, 16 Jan 2024 09:10:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p124-20020a625b82000000b006d9bdc0f765sm9945581pfb.53.2024.01.16.09.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 09:10:58 -0800 (PST)
Date: Wed, 17 Jan 2024 01:10:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: Richard Weinberger <richard@nod.at>
Cc: Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/193: Ensure user in expected group
Message-ID: <20240116171055.on2qz2zi3bijdgyi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240115212402.21888-1-richard@nod.at>
 <ZaXB6wYpoqjeGHKg@dread.disaster.area>
 <376534882.240308.1705396776298.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <376534882.240308.1705396776298.JavaMail.zimbra@nod.at>

On Tue, Jan 16, 2024 at 10:19:36AM +0100, Richard Weinberger wrote:
> Dave,
> 
> ----- Ursprüngliche Mail -----
> > Von: "Dave Chinner" <david@fromorbit.com>
> > Just do this check in _require_user(). The user needs to be set up
> > correctly for all tests - if the user and group is not set up
> > correctly, don't run any of the tests that require that user.
> > 
> > This means we don't have to play whack-a-mole with "user has no
> > group" every time someone assumes that a user is created with a
> > group by default.

I think Dave is right. Due to not only the g/193, lots of cases base
on "fsgqa* user is in fsgqa* group". If you hope to check that by
the single function _require_user_in_group(), it might need to call
it in most of cases which use _require_user.

But yes, as you said, it's weird to do it in _require_user, that makes
the _require_group calling is a bit redundant.

If I have to choose one way, I think we can keep the _require_user_in_group
as an independent function, but call it in _require_user, e.g.

_require_user()
{
        qa_user=fsgqa
        if [ -n "$1" ];then
                qa_user=$1
        fi
        _require_user_exists $qa_user
+	# fstests needs each test user is in its own group name, it only need
+	# a user exist, please use _require_user_exists directly.
+	_require_user_in_group $qa_user $qa_user
        echo /bin/true | su $qa_user
        [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
}

What do both of you think?

Thanks
Zorro

> 
> I think _require_user_exists() fits better, because _require_user()
> tests whether the user can run commands via su.
> 
> Are we all happy with something like that?
> diff --git a/common/rc b/common/rc
> index a9e0ba7e..f1eabf3c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2461,13 +2461,16 @@ _cat_group()
>         cat /etc/group
>  }
>  
> -# check if a user exists in the system
> +# check if a user exists in the system and has a user group
>  #
>  _require_user_exists()
>  {
>         local user=$1
>         _cat_passwd | grep -q "^$user:"
>         [ "$?" == "0" ] || _notrun "$user user not defined."
> +
> +       id -n -G $user | grep -w -q $user
> +       [ "$?" == "0" ] || _notrun "$user not in group $user."
>  }
>  
>  # check if a user exists and is able to execute commands.
> 
> Thanks,
> //richard
> 

