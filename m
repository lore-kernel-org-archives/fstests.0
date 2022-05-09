Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E1CC433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  9 May 2022 09:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiEIJv0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 May 2022 05:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbiEIJUf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 May 2022 05:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2155C167C5
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 02:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B042C614BD
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 09:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AF1C385A8;
        Mon,  9 May 2022 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652087790;
        bh=YQxTlvDmTHgen1E4apukNC9Q1XlV+peQ9bvg9YoUL4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slKkFy3jevU06s4gfhI8NzcsCDXHusCex3sqAMWgA+SsZs+059n68g09V/ThNQoAK
         gwgLTWWY5P/Aq2Ruzhhq58jrC0MHsIYPoAbsCBG8fVF61Hi0GOjst2e3LEICCwIboN
         2XG7TAQH4+m2GuecShPhNL0wQH0OigtAfAGklgDxxLQLBL073ISE11ChhiBwIm07HZ
         y77/4duX51tsmFCfgeabETWYY1JEFUoBKvU0dWfg4g5wTFuC4hZuO0Nz+RQGrximm9
         HkPUnzwOVkWI5bH9rW5NlE7SIZriQNc0JHDLgtBTn01B6IZMNKLYBXzDaBg1knmgHq
         w754JyXjddH+g==
Date:   Mon, 9 May 2022 11:16:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to 87cf32ad3fa2
Message-ID: <20220509091625.awordeknb2dngdy4@wittgenstein>
References: <20220508160128.DA475C385A4@smtp.kernel.org>
 <20220509033900.3gqaxzvhjezlqbqc@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509033900.3gqaxzvhjezlqbqc@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 09, 2022 at 11:39:00AM +0800, Zorro Lang wrote:
> On Mon, May 09, 2022 at 12:01:25AM +0800, Zorro Lang wrote:
> > Hi all,
> > 
> > The for-next branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > has just been updated and tagged as v2022.05.08 release.
> > 
> > In this release, Amir's patches provide "black list" support in _supported_fs,
> > and two helpers _fixed_in_version() and _fixed_by_kernel_commit() to print hints
> > for reasons of test failures. Feel free to use these helpers on new cases, or
> > improve old cases.
> > 
> > *A Kindly Reminder*
> > Next week(2022.05.09 ~ 05.15) we plan to merge a big idmapped-mounts related
> > code refactoring, details refer to:
> > 
> > https://lore.kernel.org/fstests/20220507122649.dp7iopuu7rllli7k@zlang-mailbox/
> > https://lore.kernel.org/fstests/20220507154346.oxfwcq547p325ti3@wittgenstein/T/#mf1bdf41d4a99bb4d1b90dfee2d30ac872c6074f2
> > 
> > so if you're going to write patches to change src/idmapped-mounts, better to
> > wait one more week, to avoid terrible rebasing later.
> 
> Hi Christian,

Hi Zorro,

> 
> I've sent this notification, hope to get your patchset soon :) Before offical

Thank you!

> release, I can provide a topic branch (maybe idmapped-mounts-refactoring) for
> your changes temporarily, as others might want to give it a test or write
> patches base on your changes but don't want to wait so long time.

Sure, sounds good. I'm going to base my rebase on your xfstests for-next
branch, sent them out and then you can create and apply them to that
branch!

Christian
