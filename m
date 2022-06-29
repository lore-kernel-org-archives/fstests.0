Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250D7C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 13:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiF2NMH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiF2NMG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 09:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02D241BE98
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656508325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79gRCvGMJsgXbZrgmOaMLWwCmG9hBjVV9eFfvpTttlQ=;
        b=UW7XdXlNohR0OkTIlslU5ub1j/sTGO5qxJwlTKlmeAGuzm1b0ZcMPCoIVzfCmCY98Uusvh
        gahZVL7oyOHr2wfL3gM8vQ6eUxeU2YINplw6R0FpyBzkNTmhyLgGlTf1sy4UuHPfqI+rrg
        xOk/rpPf0gxyixHV3rRRpMjvQIsjBCw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-NDtE4NGSP8eV6TCAyKX9fw-1; Wed, 29 Jun 2022 09:12:03 -0400
X-MC-Unique: NDtE4NGSP8eV6TCAyKX9fw-1
Received: by mail-qv1-f69.google.com with SMTP id jv13-20020a05621429ed00b0047048fce5bdso15221360qvb.5
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79gRCvGMJsgXbZrgmOaMLWwCmG9hBjVV9eFfvpTttlQ=;
        b=6onZguuRNTOhPblAIVY+1jEsSnozjbILOqWJapXJL/8myk3UaxwCCmnASvQeBadSfk
         hqYHhOghOE2SJjAsZhG0FfsE8rmvgGHHEAyHqnneYDe48+jIDhqVd16UYWOozJPPsbj+
         a86g+GHshGqgzmx6h88Hy0ozdAuSlDbd0k96vvQxOjQtJEfwmg1J8xIwUVtNsQ9Exzzm
         u2+W2KJCJjlQ8ZWKj3tdmWfs4ApIwdjFdjxjsUJfkgx6vKxR6JgLumFnZ7g8QwYMNr92
         GbQVKlJcJpP8wlHZZrQoPiNwSy+LVUDDuQxhD/pnejn8CXtoTTr4NdFtUUtLYktqFXJS
         3FMQ==
X-Gm-Message-State: AJIora9hRRff9XOmcao6n5lRHc7CWqD3JiMbn3+8Z/ltdiTdJHe745yK
        YbnPvGYgD0rioEm/eTt869e3x/kd6exdFRQOndyDwaiR79NIUCuljarxnzJXrUCh/iinbmsAaUf
        kbOw5QMIMFKlhj/1JxA==
X-Received: by 2002:a05:6214:dcb:b0:470:8fae:eb99 with SMTP id 11-20020a0562140dcb00b004708faeeb99mr6200815qvt.11.1656508322799;
        Wed, 29 Jun 2022 06:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tu9dNyNv8WHuARqP+IXuE2mwrZ1HbF2pnJd8vrxn4iSo1advpFbd4DxFTce4+ASJj6hqPPBQ==
X-Received: by 2002:a05:6214:dcb:b0:470:8fae:eb99 with SMTP id 11-20020a0562140dcb00b004708faeeb99mr6200776qvt.11.1656508322328;
        Wed, 29 Jun 2022 06:12:02 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bq9-20020a05620a468900b006af6f0893c6sm2245800qkb.91.2022.06.29.06.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:12:01 -0700 (PDT)
Date:   Wed, 29 Jun 2022 21:11:55 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH -v3 2/7] ext4/044: skip test if the file system does not
 have a journal
Message-ID: <20220629131155.2j4y542l4u6y736g@zlang-mailbox>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629124540.175775-3-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 08:45:35AM -0400, Theodore Ts'o wrote:
> This test mounts the file system using "mount -t ext3"; if the file
> system config creates the file system without the jbd2 journal, the
> "mount -t ext3" will fail.  So skip this test in that case.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/044 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/ext4/044 b/tests/ext4/044
> index 46e44053..158e2ac5 100755
> --- a/tests/ext4/044
> +++ b/tests/ext4/044
> @@ -16,6 +16,7 @@ _begin_fstest auto quick
>  _supported_fs ext4
>  _require_scratch
>  _require_test_program "t_get_file_time"
> +_require_metadata_journaling
>  
>  echo "Silence is golden"
>  
> -- 
> 2.31.0
> 

