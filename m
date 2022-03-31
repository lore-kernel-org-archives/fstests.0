Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D10C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 09:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiCaJGU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiCaJGL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 05:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA4039F
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 02:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78BF961976
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 09:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2274C340F0;
        Thu, 31 Mar 2022 09:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648717461;
        bh=QYXO3g/0hapkdZLGuOjgNn5qKfcPopkNlM6jbRgyIQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxnLs6h9vkXW4td/CJrtM9YPzyrWvPJkcOncfj1riHO0hJwhw2I49og5apIhCQPbH
         l0mUsol8JPi/UsO+mAHhfh/nZyeqzkJ3u0cE7lfyhvJ2qW4ZvyvBYGk+zU6o8twJV3
         fwjXehqGgcv4eio2ERauVHE3L28nUOpXW+jmlQ9+TmV7SgyEg9F4nF8yxpUu33bgVM
         fjRiW+u5gZHF5WfVjNHO+Rndr4AtcG2i/j/MEuuuzksYx9lki33V423DKsU8keM5as
         K+wBT/L9uJq6ytQhw2kqTvWRWaL3ZjQLFiuGOcXnO/LlQRVZxg7mxplwPdE6jMPDd4
         CLmZoddv6udKA==
Date:   Thu, 31 Mar 2022 11:04:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        fstests@vger.kernel.org
Subject: Re: generic/633 failing without CONFIG_USER_NS
Message-ID: <20220331090418.nr3ykkn2hethgzfy@wittgenstein>
References: <20220331082846.b4vccc3rb7lmojxs@quack3.lan>
 <20220331090051.jwrttmkol6wlv272@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331090051.jwrttmkol6wlv272@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 11:00:51AM +0200, Christian Brauner wrote:
> On Thu, Mar 31, 2022 at 10:28:46AM +0200, Jan Kara wrote:
> > Hello,
> > 
> > I have noticed that when I build a kernel without CONFIG_USER_NS,
> > generic/633 is failing. This is because despite it properly detects
> > idmapped mounts are not supported, it still tries to execute some tests
> > (such as fscaps test) and they rely on bits of user namespace support (e.g.
> > /proc/<pid>/ns/user existing). I could hack some additional support check
> > into the test but then I figured I'm not sure whether all the tests are OK
> > to skip without CONFIG_USER_NS or whether there are not some more subtle
> > dependencies... So I'm asking here :).
> 
> Hey Jan,
> 
> Thank your for detecting and reporting this. So the only ones we can
> reasonably run are the ones that don't require idmapped mount support
> and of this the actual subset that should be runnable without userns is:
> 
> { hardlink_crossing_mounts,					false,	"cross mount hardlink",										},
> { io_uring,							false,	"io_uring",											},
> { protected_symlinks,						false,	"following protected symlinks on regular mounts",						},
> { rename_crossing_mounts,					false,	"cross mount rename",										},
> { setattr_truncate,						false,	"setattr truncate",										},
> { setgid_create,						false,	"create operations in directories with setgid bit set",						},
> { setid_binaries,						false,	"setid binaries on regular mounts",								},
> { sticky_bit_unlink,						false,	"sticky bit unlink operations on regular mounts",						},
> { sticky_bit_rename,						false,	"sticky bit rename operations on regular mounts",						},
> { symlink_regular_mounts,					false,	"symlink from regular mounts",									},
> 
> I think currently we're doing:
> 
> struct t_idmapped_mounts {
> 	int (*test)(void);
> 	bool require_fs_allow_idmap;
> 	const char *description;
> };
> 
> which defines
> bool require_fs_allow_idmap
> which gets set for each test and then we can skip or execute tests
> depending on whether or not they require that.
> 
> One possible way to deal with the userns thing in there might be to make
> this a flags argument:
> 
> unsigned int required_flags;
> 
> then
> 
> #define T_REQUIRE_IDMAPPED_MOUNTS (0 << 1)
> #define T_REQUIRE_USERNS (0 << 2)

Well ok, usually when I'm not temporarily insane I tend to use:

#define T_REQUIRE_IDMAPPED_MOUNTS (1U << 0)
#define T_REQUIRE_USERNS (1U << 1)

Sorry about that.
