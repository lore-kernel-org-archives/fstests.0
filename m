Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97A7C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 07:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhLPHai (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 02:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbhLPHai (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 02:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639639837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yv4QtPyygnHJf483vYzg6JMrfSoX6rPDRaeLJZKEQ94=;
        b=dBNlG5UsG74c/sLtyzXlguyYwj++Cs8EDVl17oh1NnX2XW5YGYoOfvwJIQO27e9VtK9HJj
        1FQsJbvqSYiXuEM1m+8BWfuLMtyeDLdjIpMB17RyfUNqAm3eEfohox4fUENfbouZjUCKhi
        Fm4GRCmH22/1kaeA4kUocGoaQayw6+A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-euQqtzyrPOKGJpB3w0SOpQ-1; Thu, 16 Dec 2021 02:30:35 -0500
X-MC-Unique: euQqtzyrPOKGJpB3w0SOpQ-1
Received: by mail-pj1-f70.google.com with SMTP id v1-20020a17090a6b0100b001b12c84a1b7so378645pjj.0
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 23:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Yv4QtPyygnHJf483vYzg6JMrfSoX6rPDRaeLJZKEQ94=;
        b=Cs8UJT15+fjo7HWQy8j6ZLX845yYp2bZWzA00ZBTQ71Eu5yuLDWTm00z2j7IGD5aNX
         tiCTxcEDlvGtdkbdRW2+gChjLyOfNOv/Ja0ipvoBlAnTdOBhz4o1li5OqsFu6zOY3HMK
         0vlF2rTnMHybqjHXs9LvWsp/qAn8YFwoYSGHso888wpULpQgSW6RdJIDgFfZa5uAoE4f
         PSzSEqhjHb/JD1RsusnYoH3vYk1ucISMUzhPnk8lTqxMDMOIQ4CXKyTbK6nRfemK/ysr
         w+dZDj7sRQycV7SEXAzQ3vvg+2md/R4EZxPUYlL3fDvBpjmcJhrwbsMEgWo7Vsr2pzOk
         XBWg==
X-Gm-Message-State: AOAM530QmlnnRDE61c3N8uG2KXGy6G0UhdslLRFis2JG4UGy98Og9WOp
        BFJeXJSIUaoIF121dCoYWgeyZZMEbs9e/8s9OH2Pw+QJDqI7ERRRqhng6PK2zlmnxSrkQh+fh0G
        1S+OZY6C6ZFJYJCt2VQ==
X-Received: by 2002:a17:90a:5d0b:: with SMTP id s11mr4448399pji.176.1639639834435;
        Wed, 15 Dec 2021 23:30:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYaUHeP66YagtVPyV98vN4/A3hpAm/JldMYJEX8mZq6Yi6HYSTsMhlhpefyKEa83RGiWhrvg==
X-Received: by 2002:a17:90a:5d0b:: with SMTP id s11mr4448379pji.176.1639639834090;
        Wed, 15 Dec 2021 23:30:34 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j7sm4842196pfu.164.2021.12.15.23.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 23:30:33 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:30:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] fstress: add suport for using liburing setxattr
Message-ID: <20211216073029.lix3tj5awocvrw6l@zlang-mailbox>
Mail-Followup-To: Stefan Roesch <shr@fb.com>, fstests@vger.kernel.org,
        kernel-team@fb.com
References: <20211201055202.3142034-1-shr@fb.com>
 <20211201055202.3142034-2-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201055202.3142034-2-shr@fb.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 30, 2021 at 09:52:01PM -0800, Stefan Roesch wrote:
> Summary:
> 
> Liburing added support for setxattr. This change adds
> support for this this in fsstress when fsstress is built
> with liburing support.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  ltp/fsstress.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 003e0e49..aba7c6f7 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -145,12 +145,14 @@ typedef enum {
>  	OP_URING_WRITE,
>  	OP_WRITE,
>  	OP_WRITEV,
> +	OP_URING_SETXATTR,
>  	OP_LAST
>  } opty_t;
>  
>  typedef long long opnum_t;
>  
>  typedef void (*opfnc_t)(opnum_t, long);
> +typedef int (*setxattr_cbk)(const char *, const char *, const void *, size_t, int);
>  
>  typedef struct opdesc {
>  	opty_t	op;
> @@ -277,6 +279,7 @@ void	uring_read_f(opnum_t, long);
>  void	uring_write_f(opnum_t, long);
>  void	write_f(opnum_t, long);
>  void	writev_f(opnum_t, long);
> +void	uring_setxattr_f(opnum_t, long);
>  char	*xattr_flag_to_string(int);
>  
>  opdesc_t	ops[] = {
> @@ -347,6 +350,7 @@ opdesc_t	ops[] = {
>  	{ OP_URING_WRITE, "uring_write", uring_write_f, 1, 1 },
>  	{ OP_WRITE, "write", write_f, 4, 1 },
>  	{ OP_WRITEV, "writev", writev_f, 4, 1 },
> +	{ OP_URING_SETXATTR, "uring_setxattr", uring_setxattr_f, 1, 1 },

Due to 160a3b4b4477 "(fsstress: consistently index the ops array by OP_ type)" has been
merged, so this patchset might need to rebase on that.

Thanks,
Zorro

>  }, *ops_end;
>  
>  flist_t	flist[FT_nft] = {
> @@ -4779,8 +4783,45 @@ setattr_f(opnum_t opno, long r)
>  	close(fd);
>  }
>  
> +static int
> +io_uring_setxattr(const char *path, const char *name, const void *value, size_t size,
> +	  	 int flags)
> +{
> +	struct io_uring_sqe *sqe;
> +	struct io_uring_cqe *cqe;
> +	int ret;
> +
> +	sqe = io_uring_get_sqe(&ring);
> +	if (!sqe) {
> +		printf("io_uring_get_sqe failed\n");
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	io_uring_prep_setxattr(sqe, name, value, path, flags, size);
> +
> +	ret = io_uring_submit_and_wait(&ring, 1);
> +	if (ret != 1) {
> +		printf("io_uring_submit_and_wait failed, ret=%d\n", ret);
> +		ret = -1;
> +		goto out;
> +    	}
> +
> +	ret = io_uring_wait_cqe(&ring, &cqe);
> +	if (ret < 0) {
> +		printf("io_uring_wait_cqe failed, ret=%d\n", ret);
> +		goto out;
> +	}
> +
> +	ret = cqe->res;
> +	io_uring_cqe_seen(&ring, cqe);
> +
> +out:
> +	return ret;
> +}
> +
>  void
> -setfattr_f(opnum_t opno, long r)
> +setfattr_f_cbk(opnum_t opno, long r, setxattr_cbk cbk)
>  {
>  	int		e;
>  	pathname_t	f;
> @@ -4842,7 +4883,7 @@ setfattr_f(opnum_t opno, long r)
>  		goto out;
>  	}
>  
> -	e = setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
> +	e = cbk(f.path, name, value, value_len, flag) < 0 ? errno : 0;
>  	if (e == 0)
>  		fep->xattr_counter++;
>  	if (v)
> @@ -4854,6 +4895,20 @@ out:
>  	free_pathname(&f);
>  }
>  
> +void
> +uring_setxattr_f(opnum_t opno, long r)
> +{
> +#ifdef URING
> +	setfattr_f_cbk(opno, r, io_uring_setxattr);
> +#endif
> +}
> +
> +void
> +setfattr_f(opnum_t opno, long r)
> +{
> +	setfattr_f_cbk(opno, r, setxattr);
> +}
> +
>  void
>  snapshot_f(opnum_t opno, long r)
>  {
> -- 
> 2.30.2
> 

