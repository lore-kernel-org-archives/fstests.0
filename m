Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C6CC7618E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbjDZOu2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbjDZOu1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A2D8
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682520580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JfjUVjhvTFJqPzqYrakBKpsDihUDIg1p0I1dcN3wag0=;
        b=ADysaIJIbh1vqVOrnVKgfPIRQnHQa39XwsCU3CwitgwHcOIb10JZ4lxwE5LzoICF9l9XDC
        Rt2lztIuLGyACc+ypGbvkQuux8rAtZW7kj8dctD1P1jR+HRgtaGxCer9M6LiNOc3O+Z5Ae
        nluSY7sj4VKdq7+851DoYpSuK5E4jJ4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-KpGxzvyKPkisK_-SUOXLmA-1; Wed, 26 Apr 2023 10:49:37 -0400
X-MC-Unique: KpGxzvyKPkisK_-SUOXLmA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-63b68f53f0dso8231224b3a.1
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520576; x=1685112576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfjUVjhvTFJqPzqYrakBKpsDihUDIg1p0I1dcN3wag0=;
        b=DW9R514Lg/BoV131Owd5Mx1zNgkOSJNWiAdK78vl2qEkY14yqI3sYgTsrj6Q0uhMgy
         WmBrGgSaxx1NhQEbdhrd79wLOi4ODAtc8hacDYGIELlzzcNXa5TBCdPX0TTuA7biaTrF
         7qwA8n40dEEu/sY/c+C1hlRkylP72b2lwhec7O0PitjQ8Rf5Z81BYOe3WanShzI2R6GR
         CqizOx5BG0EgZnxMWSIlir/D3/yWDexvF1XiVFec9PX817WoColwF+SHqaxBFl0RJi6k
         xdqqgAemTWBde5UOY3KkYRJagQz34RXlM2A+OTlYJyEIUTnyP4kgw7q0lBWiYpl4/xyP
         BA1Q==
X-Gm-Message-State: AAQBX9fKpxCsh4fXsR8Sa1DzAMe+NJmIC07JIBbShLLABlF7PvWUm6nH
        qer6hFmA5ENo/aYvST7XuknqbYO36iDZeC+86mGj/5ebRiWn15ypPgSbTFacFUr1ftRsHwEwTWX
        6AlCYjyQigVQBpQ0J8A==
X-Received: by 2002:a05:6a20:a121:b0:ef:dd63:1831 with SMTP id q33-20020a056a20a12100b000efdd631831mr29475430pzk.11.1682520576473;
        Wed, 26 Apr 2023 07:49:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZANWG6pYe1WqB6RNu4kgvTh13uXjlcHb1BWYNpc6T4su59Wz46J3WozzoT8BKwLicmOI3eA==
X-Received: by 2002:a05:6a20:a121:b0:ef:dd63:1831 with SMTP id q33-20020a056a20a12100b000efdd631831mr29475404pzk.11.1682520576209;
        Wed, 26 Apr 2023 07:49:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b0063b867a1959sm11441598pfn.133.2023.04.26.07.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:49:35 -0700 (PDT)
Date:   Wed, 26 Apr 2023 22:49:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 5/6] generic/531: Check for O_TMPFILE
Message-ID: <20230426144931.uxapfrnh6adcwevd@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424141042.450535-6-dhowells@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 24, 2023 at 03:10:41PM +0100, David Howells wrote:
> Make generic/531 check that the filesystem under test supports O_TMPFILE
> before attempting to test it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
>  tests/generic/531 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/531 b/tests/generic/531
> index 5e84ca97..e5f3dddd 100755
> --- a/tests/generic/531
> +++ b/tests/generic/531
> @@ -20,6 +20,7 @@ testfile=$TEST_DIR/$seq.txt
>  # real QA test starts here
>  _supported_fs generic
>  _require_scratch
> +_require_xfs_io_command "-T"

Make sense,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _require_test_program "t_open_tmpfiles"
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> 

