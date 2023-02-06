Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B37C61DA4
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Feb 2023 14:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjBFOqA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjBFOqA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2023 09:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F15123D8A
        for <fstests@vger.kernel.org>; Mon,  6 Feb 2023 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675694712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFFgACxMG63xsljBooyBd6MYtPMvPQ8ghvIJM8Z5ucQ=;
        b=Fb/x2PO5tioe0iNGqs0ybQooA0u111vEZDnjRuN/KJMUyQDYVt7t7wiO+4cz+/r2PeXz4e
        XOtVb/vyzTRVzA5CnwzPvLJj2q1D5YaMe8KbFsQNkrFbKF9JNKIINz0Nh7ZDcHb08qtqdL
        grjCxSHIlvkOzNC5GqM6JMqAJEZ+XXw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-7xEfQYjiMUerOIpQbQGPew-1; Mon, 06 Feb 2023 09:45:11 -0500
X-MC-Unique: 7xEfQYjiMUerOIpQbQGPew-1
Received: by mail-pg1-f197.google.com with SMTP id e11-20020a63d94b000000b0048988ed9a6cso5188675pgj.1
        for <fstests@vger.kernel.org>; Mon, 06 Feb 2023 06:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFFgACxMG63xsljBooyBd6MYtPMvPQ8ghvIJM8Z5ucQ=;
        b=LIY5Y+YVzN6aes55XaW/wrLICzQSd+IhpLgwAxkFJmu2gXVUbiqm8xUBJVpTSqrdgJ
         b5Y3RG+0zbtgpRFW6wG9ZEAgSQAY9KDBXX5fYa3H0rcY84UEFBTw9CM/+8nNp534h2gN
         EXrBDPphdHfYbLTrTztUHvQXDs8BWKLlBAuZmdtULIl0l4wdnTyqDHAUNjRqZad6SGGw
         /NJ7oK1Z+t+HOmfVmf7Zl+OlL83fF56pktrBFObx8z9wn5zgR9rw6Nt3B2IQGPID55DS
         rGDOtpSF71it5mfKYYlApTlR7pucZxe8JTE32ZWxnH5StxFJBUTalS7O5UAA4aYeUUvS
         hLMw==
X-Gm-Message-State: AO0yUKVo+sIhgXnSvnoyLb4Ug1dkzcSJ5DNr90CJmTEvjM5OGEQRkJfR
        c81P+oOtF2GWI/6j5zjrrL22N6KZrIPKIfsYz3IF0YbI6z9Bk1HaCmrbQ+JYLvthsLoQIH0X1fh
        uSZbM71KacomHpjaMsQ==
X-Received: by 2002:a17:902:e5c3:b0:197:9036:e70d with SMTP id u3-20020a170902e5c300b001979036e70dmr25257033plf.29.1675694710396;
        Mon, 06 Feb 2023 06:45:10 -0800 (PST)
X-Google-Smtp-Source: AK7set9dOrmcn4NebQhbhs3w9WoMgkRMjVVDJNiXxzL7gn4Uf9FXMVb8TyvkZCmVhGxJI81izua9/A==
X-Received: by 2002:a17:902:e5c3:b0:197:9036:e70d with SMTP id u3-20020a170902e5c300b001979036e70dmr25257004plf.29.1675694710051;
        Mon, 06 Feb 2023 06:45:10 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902c38200b00198f9f9c612sm4346960plg.179.2023.02.06.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:45:09 -0800 (PST)
Date:   Mon, 6 Feb 2023 22:45:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] README: Add section to install required packages on
 (open)SUSE
Message-ID: <20230206144505.ymxhrsnf44zilo4i@zlang-mailbox>
References: <20230131123839.16084-1-gniebler@suse.com>
 <20230131123839.16084-2-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131123839.16084-2-gniebler@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 31, 2023 at 01:38:38PM +0100, Gabriel Niebler wrote:
> The README already lists how to install the required packages on other popular
> distributions. Since a lot of filesystem development happens on SUSE systems and
> both the commands as well as the list of packages are slightly different,
> it only makes sense to include these as well.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---

No objection from me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  README | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/README b/README
> index 4c4f22f8..008d3875 100644
> --- a/README
> +++ b/README
> @@ -77,6 +77,26 @@ RHEL or CentOS
>      For OverlayFS build and install:
>       - see https://github.com/hisilicon/overlayfs-progs
>  
> +SUSE Linux Enterprise or openSUSE
> +---------------------------------
> +
> +1. Install all necessary packages from standard repositories:
> +
> +   $ sudo zypper install acct automake bc dbench duperemove dump fio gcc git \
> +        indent libacl-devel libaio-devel libattr-devel libcap libcap-devel \
> +        libtool liburing-devel libuuid-devel lvm2 make quota sqlite3 xfsprogs
> +
> +2. Install packages for the filesystem(s) being tested:
> +
> +    For btrfs install:
> +     $ sudo zypper install btrfsprogs libbtrfs-devel
> +
> +    For XFS install:
> +     $ sudo zypper install xfsdump xfsprogs-devel
> +
> +    For OverlayFS build and install:
> +     - see https://github.com/hisilicon/overlayfs-progs
> +
>  Build and install test, libs and utils
>  --------------------------------------
>  
> -- 
> 2.39.1
> 

