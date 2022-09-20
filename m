Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B6C54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 14:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiITOuO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiITOuN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 10:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7683B24BE3
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 07:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12512626E5
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 14:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F339EC433D6;
        Tue, 20 Sep 2022 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663685411;
        bh=W+oR59i8f67OS47oFdgmx5LqUGzOTIKW4DknnzJNbUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjNGbwHJJCHQxdXFQqlY8kamLcZMvsEuUvo2q3shcxoi6EqzWG5gZnbOCPiI+0WI8
         AzSneAj0lf9gFiQ8TZLMDY3OISlwi2nIK64Q1MSqVAOmK8qYRrEXcTX62lD6OU9M+Q
         QphtX4e6z9HP8qwieLZq+ugvsSg+RgNgz/vqH3mVDlNwZjPxfdFbBj9l20/CPW16Sh
         L5/oE9Fu6aXVZxnTwkNhfBGFjkZzR8lRGeeVhd3YZA0ixIfryVZTVj59U/BT07E5x+
         NSL/TsL7gKnTIxvM/z65IlsP4N1UU9CoMMzgmu44AKUcwLPptmM3yL9Fcca928UeL5
         W2O2P5abfl3cQ==
Date:   Tue, 20 Sep 2022 16:50:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, sforshee@digitalocean.com,
        amir73il@gmail.com, hch@lst.de, cyphar@cyphar.com
Subject: Re: [PATCH v4 0/2] group ownership changing test
Message-ID: <20220920145006.bsrinbmqwrk5kl7w@wittgenstein>
References: <20220920115035.2472076-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920115035.2472076-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 20, 2022 at 07:50:33PM +0800, Zorro Lang wrote:
> Hi Christian,
> 
> It's been 3 month past, since your patch [1] was reviewed last time. I'm still
> waititng for this test coverage for fs. According to the review points last
> time, I split your v3 patch [1] to 2 separated cases, one basic testing for
> covering that fix, one extend testing for overlay part.
> 
> I only did below changes (compare with v3):
> 1) Split one case to two cases.
> 2) Move "_supports_filetype" line under the _scratch_mount.
> 
> I still keep the patch Author as you, and signed-off-by you, due to I just
> hope to bring this discussion back, and push the proceeding of this patch
> be merged.
> 
> (CC the old cc list to get more review)
> 
> Thanks,
> Zorro
> 
> [1]
> https://lore.kernel.org/fstests/20220615092826.2333847-1-brauner@kernel.org/

Zorro,

Thank you for picking this patchset up! I just didn't have the time.
I've applied it, reviewed, and tested it:

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>

We really need this regression test!

Christian
