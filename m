Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16540C61DA4
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Feb 2023 14:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBIOzZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBIOzY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Feb 2023 09:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE1E60BB0
        for <fstests@vger.kernel.org>; Thu,  9 Feb 2023 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675954479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2ZzUYO5mab7NH6zNDpFisSE90YwfjnV8FRs9Fjymho=;
        b=TR9CIzKgjhecQYNtQHXvlFmvqpHtcYMvqJoXm1ZGBAoj6hbidELOJQKl6Lz95F7zJ0UALG
        YVQ3Qy8DuXgdOKQYxjkeUDyFUB6mfwKTI5JCiA5zbuznOoW0AobVx7/tZkzsRw481qLG35
        PmIaKd1nqknvKeK2IazJUq1DIAi1VPU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-IPPJ8Y3KMbCIGT6Fr3_ujQ-1; Thu, 09 Feb 2023 09:54:37 -0500
X-MC-Unique: IPPJ8Y3KMbCIGT6Fr3_ujQ-1
Received: by mail-pf1-f197.google.com with SMTP id u3-20020aa78383000000b005a8534314aeso1147326pfm.17
        for <fstests@vger.kernel.org>; Thu, 09 Feb 2023 06:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2ZzUYO5mab7NH6zNDpFisSE90YwfjnV8FRs9Fjymho=;
        b=PMrmo9qIBemAomiXG+dMIDNRx2SKVuu9GfQWaOosBq8XpoonyII3+QnAhhqqC8TqLe
         vrIaozE1LRz83XGUyq0S11A+L5Iu3ogMTMJC9WcDXlQ8hQXBLuLn8vgMn4a45jHizGNI
         D0XGdLf6iWhBbLl6yh6k4brqXKgvcxfWs7Ha8zf2iaSIf0zoKJK7BeXbZKp12JrukqmZ
         2NrKGD7h5LWTVN2g6B2pSZQJXMcUCDiyXN7JozRUTEJq7JJCNk+TnlbrM2spPVL94sNz
         a/wONROfqpeLvkWr9mRuMFMYT/MMTG468A0gyTM8/gaKbAjqoCcKW9n/KiUBY5tRYijv
         8Opg==
X-Gm-Message-State: AO0yUKViFvzHt4RFVqZsAHnPNm2wubHlcFcuYQJHQ+80tmQAjzKIJ7y1
        14YpNyCElaSMlbUghUSmcfcQ7MqW7rjnrpIGPSwhQPpACqv1P8R+h7v0qfws+ahrdMfyBH3SQ50
        7F73jRxlaNf2X9zo8nm7cTiRmlYbY
X-Received: by 2002:a17:903:124d:b0:196:f00:c8f9 with SMTP id u13-20020a170903124d00b001960f00c8f9mr12873173plh.10.1675954476557;
        Thu, 09 Feb 2023 06:54:36 -0800 (PST)
X-Google-Smtp-Source: AK7set915TdCrfcCD8fcrLoFn5/dNaQLXuxUMas0v0zDzuAbz9dOnr6FEwVtVaiBcSae4LNq1gn8Nw==
X-Received: by 2002:a17:903:124d:b0:196:f00:c8f9 with SMTP id u13-20020a170903124d00b001960f00c8f9mr12873144plh.10.1675954476205;
        Thu, 09 Feb 2023 06:54:36 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001992b8cf89bsm1611146plk.16.2023.02.09.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:54:35 -0800 (PST)
Date:   Thu, 9 Feb 2023 22:54:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/676: Unstable d_type handling for NFS READDIR
Message-ID: <20230209145432.5uxkp56sgl7v7gmr@zlang-mailbox>
References: <42d3218724fbe3758005f984ad85934a50c33611.1675348307.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d3218724fbe3758005f984ad85934a50c33611.1675348307.git.bcodding@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 02, 2023 at 09:48:04AM -0500, Benjamin Coddington wrote:
> The NFS client may send READDIR or READDIRPLUS to populate the dentry
> cache, and switch between them to optimize for least RPC calls based on the
> process' behavior.  When using READDIR, dentries will have d_type =
> DT_UNKNOWN but with READDIRPLUS d_type will be set from the mode.
> 
> This heuristic will cause generic/676 to fail when comparing dentries
> cached from one or the other call, since we compare d_type directly. Fix
> this by bypassing the comparison of d_type if any entry is loaded with
> DT_UNKNOWN.
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---

OK, thanks for this fix from nfs side. I think it doesn't affect other fs
testing, then I'd like to merge it if it's helpful for nfs side. If anyone
has objection, please tell us.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  src/t_readdir_3.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/src/t_readdir_3.c b/src/t_readdir_3.c
> index e5179ab27c51..8f9bb326dccb 100644
> --- a/src/t_readdir_3.c
> +++ b/src/t_readdir_3.c
> @@ -27,6 +27,7 @@ struct linux_dirent64 {
>  static DIR *dir;
>  static int dfd;
>  static int ignore_error;
> +static int ignore_dtype = 0;
>  
>  struct dir_ops {
>  	loff_t (*getpos)(void);
> @@ -61,6 +62,10 @@ static void libc_getentry(struct dirent *entry)
>  		exit(1);
>  	}
>  	memcpy(entry, ret, sizeof(struct dirent));
> +
> +	/* NFS may or may not set d_type, depending on READDIRPLUS */
> +	if (!ignore_dtype && entry->d_type == DT_UNKNOWN)
> +		ignore_dtype = 1;
>  }
>  
>  static off64_t kernel_getpos(void)
> @@ -95,6 +100,10 @@ static void kernel_getentry(struct dirent *entry)
>  	entry->d_reclen = lentry->d_reclen;
>  	entry->d_type = lentry->d_type;
>  	strcpy(entry->d_name, lentry->d_name);
> +
> +	/* NFS may or may not set d_type, depending on READDIRPLUS */
> +	if (!ignore_dtype && entry->d_type == DT_UNKNOWN)
> +		ignore_dtype = 1;
>  }
>  
>  struct dir_ops libc_ops = {
> @@ -168,8 +177,9 @@ static void test(int count, struct dir_ops *ops)
>  		pos = random() % count;
>  		ops->setpos(pbuf[pos]);
>  		ops->getentry(&entry);
> +
>  		if (dbuf[pos].d_ino != entry.d_ino ||
> -		    dbuf[pos].d_type != entry.d_type ||
> +		    (!ignore_dtype && dbuf[pos].d_type != entry.d_type) ||
>  		    strcmp(dbuf[pos].d_name, entry.d_name)) {
>  			fprintf(stderr,
>  				"Mismatch in dir entry %u at pos %llu\n", pos,
> -- 
> 2.31.1
> 

