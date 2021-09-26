Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A816C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Sep 2021 09:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1224C60EE2
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Sep 2021 09:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhIZJx4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Sep 2021 05:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbhIZJxz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Sep 2021 05:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632649937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9QfETEao2+uZZOw+WpmdC/V0MqR+SYKti+Q0i9WhmOo=;
        b=FJ7NkgD5k6kPUcPXqr58jDyXgugdbyZ/srTEBO3COXqVqZ3axV711UxdstAQABCmzS4JRt
        zyEvRXd6Xa6fJoDz+v7FQ+7ziRtB0SXdAUq08il5fUiMrP/CB1/MwrAtuQrGriuRDdcTVJ
        Fc7v+0AqABl0AqO/Dm7D4lZYQMbWkT4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-qLfFF81sMoWXfssV7f_JAA-1; Sun, 26 Sep 2021 05:52:13 -0400
X-MC-Unique: qLfFF81sMoWXfssV7f_JAA-1
Received: by mail-pg1-f198.google.com with SMTP id n9-20020a63f809000000b0026930ed1b24so10410347pgh.23
        for <fstests@vger.kernel.org>; Sun, 26 Sep 2021 02:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9QfETEao2+uZZOw+WpmdC/V0MqR+SYKti+Q0i9WhmOo=;
        b=IvT+xpA0MV/BIo+jjFczcskLEoVP8A45B1qyy8gwtR+weegNc2tnd5JEcy8U/Vw6Lu
         rWXe24vdhrH8QELd6h7woYcXSvCMGRQ+Z5PEfhknqQlflVO6F3eDjgVubB7Y+1Orfbcg
         O4ht+QYDETPWqrjwMr6BTIYRxIZMs0x9FrfsAT6uWNyI90zA/mE/SD6YofGRGsNEF4h+
         ZtO0/6ETcIQbcoWd+dr7RWFOD454C/awxf4qUP8WcKfaDnCbwI/JuTNfHVeNXfWzR9cx
         smfEjvwtml2zAzBM4uN0G5cjODIofi1qs4UTDtjTpG/JkgbUAPWq5M/Ol5cW9jt4rCiP
         LMYw==
X-Gm-Message-State: AOAM532QQDPigUhgNf54GJK9lI08Ng8xWungD5taujGcIqB5Bv/31NG1
        7s69odpyvMGji/QwpxAvGON/q87nujaBrw9wc3eqqh/AUoeIapYSmpQKTetGJHvHs5uZPIToeUg
        wN9KifwLkD1v9E9n01Q==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr12891038pjb.80.1632649932143;
        Sun, 26 Sep 2021 02:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY95PawLc41ntqzCVUZgoGSFjRzgcV2In2F3OlWqGxBuk6aZCAEIWG2qt8ussBQcn7BS6OBg==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr12891030pjb.80.1632649931820;
        Sun, 26 Sep 2021 02:52:11 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y15sm14030368pfq.32.2021.09.26.02.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 02:52:11 -0700 (PDT)
Date:   Sun, 26 Sep 2021 18:13:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 1/2] common/rc: add _require_user_exists() to check if
 a user exists
Message-ID: <20210926101354.gniy2ytswm662y5y@fedora>
Mail-Followup-To: Luis Henriques <lhenriques@suse.de>,
        fstests@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20210924091911.19413-1-lhenriques@suse.de>
 <20210924091911.19413-2-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924091911.19413-2-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 24, 2021 at 10:19:10AM +0100, Luis Henriques wrote:
> Function _require_user() does check if a user exists *and* if it is able
> to execute commands.  Add a new function to simply check if a user exists.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
>  common/rc | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 154bc2dd7e94..de9ba56eefcf 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2289,18 +2289,27 @@ _cat_group()
>  	cat /etc/group
>  }
>  
> -# check for a user on the machine, fsgqa as default
> +# check if a user exists in the system
> +#
> +_require_user_exists()
> +{
> +	local user=$1
> +	_cat_passwd | grep -q $user
> +	[ "$?" == "0" ] || _notrun "$user user not defined."

As _require_user() does "su $qa_user" after the "grep", so it really make sure
there's an "user". But if the _require_user_exists() only trys to grep /etc/passed
to make sure there's an "$user", I'd like to make the "grep" condition be more exact.
For example, if there's an user "myuser100" in the /etc/passwd, then _require_user_exists
"myuser" or "user100" or "user1" or "user10" all return 0.

So how about:
  _cat_passwd | grep -qw $user

Or more exact:
  _cat_passwd | cut -d: -f1 | grep -qw $user

Or other better command line:)

Thanks,
Zorro

> +}
> +
> +# check if a user exists and is able to execute commands.
> +# Uses 'fsgqa' user as default.
>  #
>  _require_user()
>  {
> -    qa_user=fsgqa
> -    if [ -n "$1" ];then
> -        qa_user=$1
> -    fi
> -    _cat_passwd | grep -q $qa_user
> -    [ "$?" == "0" ] || _notrun "$qa_user user not defined."
> -    echo /bin/true | su $qa_user
> -    [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
> +	qa_user=fsgqa
> +	if [ -n "$1" ];then
> +		qa_user=$1
> +	fi
> +	_require_user_exists $qa_user
> +	echo /bin/true | su $qa_user
> +	[ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
>  }
>  
>  # check for a chown support
> 

