Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB882C433F5
	for <linux-fstests@archiver.kernel.org>; Sun,  1 May 2022 14:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiEAObf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 May 2022 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347633AbiEAObe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 May 2022 10:31:34 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74E252BB
        for <fstests@vger.kernel.org>; Sun,  1 May 2022 07:28:08 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 1so8842094qvs.8
        for <fstests@vger.kernel.org>; Sun, 01 May 2022 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d7QK1GW7lP1qbCKVFdvjJcmsoTKCx8yr/Y/NGlYiKTM=;
        b=adi/Q4rjKqdJ5NyijvTh1FJ32lctyt9gegxOKlUti0QGPejTQABqCgz44IhGhe66Fz
         9nmXtaQuovlthu7nO534E3gHVljWv4PqzjD3BbK5VUA0o6nzd/uzg+lIYFzXOb54whg3
         kIbVQKuq4z90kptZ3Nrta3L78pw8s4nqCBEAbczZ0caWe3s3F6OYSOaH2/hi4mnE9ic+
         1FRUiboQS8E1CH+uF3lKsZg0eKvBZAa/evxhcv5wIMzhUWcRfNeclGn85MQnq867GtM6
         dK8fjPu6Q5OQQFJqi9tJz5O0/wdxXKJqnduZ5VZsRt0tNQg5eJPoxRGilZ8rkS+roWlW
         VMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d7QK1GW7lP1qbCKVFdvjJcmsoTKCx8yr/Y/NGlYiKTM=;
        b=f4wTJxQ8QViZxCVjSo83bgXusS2ObwkhAy6xpANoz5vifA38LLbpcqAqGsnud7/9ss
         drC9NzAntLRvW4o0q7lN/k+JAPf+9yZYbhLKgyD8Sxl5yA5u2kJkPH+mEK/Bz5UEjirx
         v2AjdjqD4HZARAzULFxGUASCKsKIDNyigdey/i1vX/9YjW+Ar7wlh9ugj1iAmJ1eiH3p
         gkQypBDS84ob6MnirUTvrUP6c9S5ygeBW1AFlsZalw+1e127OE+Br0CUu1z1VFwacQp6
         u8l3BRhUyCqn5oVOh9QNtkqEs0jUsYWGqjp1WyUB9E/kmoFpkHTbN7GVdDKPgpZdj5oS
         DRmg==
X-Gm-Message-State: AOAM530wNf6WVaNxzanVMopfZFEHjkDH4in5umn3tavxeTnNhmVNDOAf
        +huq0pK01L33LUeqMMrN1gUuhQ==
X-Google-Smtp-Source: ABdhPJxGzSX6uTX86FySckLDq4xHvc4dBX/esxM/eMsLRFoUMsoS1L2OIYV+7fjmcg9SgJajescjMQ==
X-Received: by 2002:a05:6214:5282:b0:443:e161:ef4a with SMTP id kj2-20020a056214528200b00443e161ef4amr6311029qvb.23.1651415287932;
        Sun, 01 May 2022 07:28:07 -0700 (PDT)
Received: from localhost ([173.95.209.66])
        by smtp.gmail.com with ESMTPSA id d26-20020ac847da000000b002f39b99f66esm2762722qtr.8.2022.05.01.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 07:28:07 -0700 (PDT)
Date:   Sun, 1 May 2022 10:28:06 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v9 1/5] common/verity: require corruption functionality
Message-ID: <Ym6Y9pMybZcSeHTm@localhost.localdomain>
References: <cover.1651012461.git.boris@bur.io>
 <657cd5facdbd0b41ee99ab18ad0bba9f0d690729.1651012461.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657cd5facdbd0b41ee99ab18ad0bba9f0d690729.1651012461.git.boris@bur.io>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 26, 2022 at 03:40:12PM -0700, Boris Burkov wrote:
> Corrupting ext4 and f2fs relies on xfs_io fiemap. Btrfs corruption
> testing will rely on a btrfs specific corruption utility. Add the
> ability to require corruption functionality to make this properly
> modular. To start, just check for fiemap, as that is needed
> universally for _fsv_scratch_corrupt_bytes.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
